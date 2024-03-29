//
//  Utilities.swift
//  LandmarkRemark
//
//  Created by Parth on 30/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation
import CoreLocation

class Utilities {
    
    static func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func isValidEmailID(_ email : String) -> Bool {
        let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func isValidUsername(_ username : String) -> Bool {
        if username.count > 10 {
            return false
        }
        return true
    }
    
    static func ifUserNameAlreadyExists(_ username : String, completion: @escaping (_ exists:Bool ) -> Void) {
        Utilities.filterDocumentsWithFieldValue(fieldName: "username", fieldValue: username, completionHandler: { (err, arr) in
            completion(arr.count != 0)
        })
    }
    
    static func locationPermissionCheck() -> Bool {
        var permissionFlag = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                permissionFlag = false
            case .authorizedWhenInUse:
                permissionFlag = true
            case .authorizedAlways:
                permissionFlag = false
            }
        } else {
            print("Location services are not enabled")
        }
        return permissionFlag
    }
}
