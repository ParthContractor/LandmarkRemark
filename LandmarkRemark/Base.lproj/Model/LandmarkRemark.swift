//
//  LandmarkRemark.swift
//  LandmarkRemark
//
//  Created by Parth on 04/12/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation

public struct LandmarkRemark {
    let uid: String
    let username: String
    let remark: String
    let latitude: Double
    let longitude: Double
}

extension LandmarkRemark: Codable {} // preserves memberwise initializer
