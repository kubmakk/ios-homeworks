//
//  MapViewController.swift
//  Navigation
//
//  Created by kubmakk on 10/10/25.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    private var routePlotted = false
    private var isUserTrackingEnabled = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        setupLocationManager()
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
        pin.title = "Мое местоположение"
        pin.subtitle = "Мое текущее местоположение"
        mapView.addAnnotation(pin)
}
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !routePlotted {
            centerViewOnUserLocation()
            addPinToUserLocation()
            routePlotted = true
        }
        manager.stopUpdatingLocation()
    }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Ошибка получения геолокации: \(error.localizedDescription)")
        }
    }
    

