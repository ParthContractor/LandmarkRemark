//
//  UserAnnotation.swift
//  LandmarkRemark
//
//  Created by Parth on 04/12/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import MapKit

//This annotation is specifically for current location of user
class UserAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
