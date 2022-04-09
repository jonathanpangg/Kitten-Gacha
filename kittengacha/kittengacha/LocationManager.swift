//
//  LocationManager.swift
//  kittengacha
//
//  Created by Jonathan Pang on 4/9/22.
//
 
import Foundation
import CoreLocation
import CoreLocationUI
import SwiftUI
 
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
 
    @Published var location: CLLocationCoordinate2D?
 
    override init() {
        super.init()
        manager.delegate = self
    }
 
    func requestLocation() {
        manager.requestLocation()
    }
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
}
