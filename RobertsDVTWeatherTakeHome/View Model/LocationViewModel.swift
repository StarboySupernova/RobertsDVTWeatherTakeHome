//
//  LocationViewModel.swift
//  RobertsDVTWeatherTakeHome
//
//  Created by Simbarashe Dombodzvuku on 2/6/23.
//

import Foundation

import SwiftUI
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published public var lastSeenLocation: CLLocation?
    @Published var currentPlacemark: CLPlacemark?
    @Published var favourited: [CLLocation : CLPlacemark] = [:]
    public static var shared = LocationViewModel()
    static var customLocation: CLLocationCoordinate2D?
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        #warning("locationManager.requestLocation here, and accuracy three kilometers, and requestWhenInUseLocation inside init")
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
        fetchCountryAndCity(for: locations.first)
    }

    func fetchCountryAndCity(for location: CLLocation?) {
        guard let location = location else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            self.currentPlacemark = placemarks?.first
        }
    }    
}

extension LocationViewModel {
    static var defaultLocation: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: -26.202270, longitude: 28.043630)
    }
    
    static func locationProvider(latitude: Double? = nil, longitude: Double? = nil) {
        if (latitude == nil) || (longitude == nil) {
            return
        } else {
            customLocation = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        }
    }
}
