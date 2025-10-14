//
//  MapViewController.swift
//  Navigation
//
//  Created by kubmakk on 10/10/25.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
        setupLocationManager()
        configureMapApperance()
        addTapGestureToMap()

        mapView.delegate = self
    }

    private func setupMapView() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAuthorization()
    }

    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        case .denied:
            print("Отказано в доступе")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Доступ ограничен")
        @unknown default:
            fatalError("Ошибка геолокации")
        }
    }

    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 2000, longitudinalMeters: 2000)
            mapView.setRegion(region, animated: true)
        }
    }

    private func addPinToUserLocation() {
        guard let userLocation = locationManager.location?.coordinate else { return }
        let pin = MKPointAnnotation()
        pin.coordinate = userLocation
        pin.title = "Мое местоположение"
        mapView.addAnnotation(pin)
    }

    private func addTapGestureToMap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }

    @objc private func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)

        mapView.removeOverlays(mapView.overlays)
        mapView.annotations.forEach { annotation in
            if annotation.title == "Точка назначения" {
                mapView.removeAnnotation(annotation)
            }
        }

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Точка назначения"
        mapView.addAnnotation(annotation)

        plotRoute(to: coordinate)
    }

    private func plotRoute(to destinationCoordinate: CLLocationCoordinate2D) {
        guard let sourceCoordinate = locationManager.location?.coordinate else {
            print("Не получилось получить местоположение")
            return
        }

        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)

        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

        let request = MKDirections.Request()
        request.source = sourceItem
        request.destination = destinationMapItem
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { [weak self] (response, error) in
            guard let self = self, let response = response else {
                if let error = error {
                    print("Ошибка построении машрута: \(error.localizedDescription)")
                }
                return
            }

            guard let route = response.routes.first else { return }

            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
        }
    }

    private func configureMapApperance() {
        mapView.mapType = .standard
        mapView.showsBuildings = true
        mapView.showsCompass = true
        mapView.showsTraffic = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsPointsOfInterest = true
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            centerViewOnUserLocation()
            addPinToUserLocation()
            manager.stopUpdatingLocation()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка получения геолокации: \(error.localizedDescription)")
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer()
    }
}
