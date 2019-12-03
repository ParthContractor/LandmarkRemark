//
//  HomeScreenViewModel.swift
//  LandmarkRemark
//
//  Created by Parth on 03/12/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation

class HomeScreenViewModel {
    let navigationBarTitle: String

    var locationProvider: UserLocationProvider
    var userLocation: UserLocation?

    var allLandmarkRemarksArray = [LandmarkRemark]()

    init(locationProvider: UserLocationProvider) {
        self.navigationBarTitle = "Landmark Remark"
        self.locationProvider = locationProvider
    }
    
    func getAllLandmarkRemarks(completion: @escaping () -> Void) {
        allLandmarkRemarksArray.removeAll()
        Utilities.getAllDocuments(completionHandler: {(error,arrayOfDicts) in
            do {
                let json = try JSONSerialization.data(withJSONObject: arrayOfDicts)
                let decoder = JSONDecoder()
                let decodedRemarks = try decoder.decode([LandmarkRemark].self, from: json)
                self.allLandmarkRemarksArray = decodedRemarks
                completion()
            } catch {
                completion()
            }
        })
    }
}
