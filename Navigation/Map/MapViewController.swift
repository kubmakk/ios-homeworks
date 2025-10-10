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
    
    private var routePlotted = false
    
    //MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        setupLocationManager()
        configureMapApperance()
        
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
        locationManager.distanceFilter = 1
        checkLocationAuthorization()
        
    }
    
    private func checkLocationAuthorization(){
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        case .denied:
            print("Отказано в доступе")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization( )
        case .restricted:
            print("Доступ ограничен")
        @unknown default:
            fatalError("Ошибка геолокации")
        }
    }
    
    private func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    private func addPinToUserLocation(){
    guard let userLocation = locationManager.location?.coordinate else { return }
        
        let pin = MKPointAnnotation()
        pin.coordinate = userLocation
        pin.title = "Казахстан🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿"
        pin.subtitle = "Тут казасхатан🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿🇰🇿"
        mapView.addAnnotation(pin)
}
    private func plotRoute() {
        guard let sourceCoordinate = locationManager.location?.coordinate else {
            print("Не получилось получить местоположение")
            return
        }
        
        // 🔥 Отладочный print
        print("Строим маршрут от: \(sourceCoordinate.latitude), \(sourceCoordinate.longitude)")
        
        
        let destinationCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 52.5186, longitude: 13.3777)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Точка назначения"
        
        destinationAnnotation.coordinate = destinationCoordinate
        mapView.addAnnotation(destinationAnnotation)
        
        let request = MKDirections.Request()
        request.source = sourceItem
        request.destination = destinationMapItem
        request.transportType = .walking
        
        
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] (response, error) in
            guard let self = self, let response = response else {
                if error != nil {
                    print("Ошибка построении машрута \(error?.localizedDescription)")
                }
                return
            }
            
            let route = response.routes[0]
            
            self.mapView.addOverlay(route.polyline, level: .aboveLabels)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
        }
    }
    
    private func configureMapApperance(){
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
        if !routePlotted {
            centerViewOnUserLocation()
            addPinToUserLocation()
            plotRoute()
            routePlotted = true
        }
        manager.stopUpdatingLocation()
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
            renderer.lineWidth = 6
            return renderer
        }
        return MKOverlayRenderer()
    }
}
