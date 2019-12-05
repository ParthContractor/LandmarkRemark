//
//  LandmarkListViewModel.swift
//  LandmarkRemark
//
//  Created by Parth on 05/12/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation

class LandmarkListViewModel {
    let navigationBarTitle: String
    let searchBarPlaceHolder: String
    
    var filteredLandmarkRemark = [LandmarkRemark]()
    
    var error: String?

    init() {
        self.navigationBarTitle = "Landmark Remark"
        self.searchBarPlaceHolder = "Search landmark by username or remark.."
    }
    
    func searchLandmarkRemarks(text: String, completion: @escaping () -> Void) {
        filteredLandmarkRemark.removeAll()
       
        Utilities.filterDocumentsWithFieldValue(fieldName: AppConstants.usernameKey, fieldValue: text, completionHandler: {(err, arrayOfDicts) in
            self.error = err?.localizedDescription
            if arrayOfDicts.count != 0 {
                do {
                    let json = try JSONSerialization.data(withJSONObject: arrayOfDicts)
                    let decoder = JSONDecoder()
                    let decodedRemarks = try decoder.decode([LandmarkRemark].self, from: json)
                    self.filteredLandmarkRemark = decodedRemarks
                    completion()
                } catch {
                    completion()
                }
            }
            else{
                completion()
            }
        })
    }
}
