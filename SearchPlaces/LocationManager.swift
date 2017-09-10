//
//  LocationManager.swift
//  SearchPlaces
//
//  Created by SimpuMind on 9/3/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class LocationManager: CLLocationManager, CLLocationManagerDelegate  {
    private var latitude:Double
    private var longitud:Double
    private let locationManager = CLLocationManager()
    
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
    override init() {
        self.latitude = 0.0
        self.longitud = 0.0
        self.locationManager.requestWhenInUseAuthorization()
        
        super.init()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.allowsBackgroundLocationUpdates = false
            self.locationManager.activityType = .other
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        }
    }
    
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
        
        self.latitude = locValue.latitude
        self.longitud = locValue.longitude
    }
    
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
    func getLatitude()->NSNumber{
        return self.latitude as NSNumber
    }
    
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
    func getLongitude()->NSNumber{
        return self.longitud as NSNumber
    }
    
}
