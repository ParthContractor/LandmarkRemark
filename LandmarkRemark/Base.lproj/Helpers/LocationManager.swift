//
//  LocationManager.swift
//  LandmarkRemark
//
//  Created by Parth on 03/12/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation
import CoreLocation

typealias Coordinate = CLLocationCoordinate2D

protocol UserLocation {
    var coordinate: Coordinate { get }
}

extension CLLocation: UserLocation { }

enum UserLocationError: Swift.Error {
    case canNotBeLocated
}

typealias UserLocationCompletionHandler = (UserLocation?, UserLocationError?) -> Void

protocol UserLocationProvider {
    func findUserLocation(then: @escaping UserLocationCompletionHandler)
}

protocol LocationProvider {
    var isUserAuthorized: Bool { get }
    func requestWhenInUseAuthorization()
    func requestLocation()
}

extension CLLocationManager: LocationProvider {
    var isUserAuthorized: Bool {
        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
}

class LocationManager: NSObject, UserLocationProvider {
    
    fileprivate var provider: LocationProvider
    fileprivate var locationCompletionHandler: UserLocationCompletionHandler?
    
    init(with provider: LocationProvider) {
        self.provider = provider
        super.init()
    }
    
    func findUserLocation(then: @escaping UserLocationCompletionHandler) {
        self.locationCompletionHandler = then
        if provider.isUserAuthorized {
            provider.requestLocation()
        } else {
            provider.requestWhenInUseAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            provider.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let location = locations.last {
            locationCompletionHandler?(location, nil)
        } else {
            locationCompletionHandler?(nil, .canNotBeLocated)
        }
    }
}
