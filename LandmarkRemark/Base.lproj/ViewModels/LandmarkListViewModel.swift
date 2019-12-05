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
    private var allLandMarkRemarks = [LandmarkRemark]()

    var error: String?

    init() {
        self.navigationBarTitle = "Landmark Remark"
        self.searchBarPlaceHolder = "Search landmark by username or remark.."
        self.getAllLandmarkRemarks()
    }
    
    func searchLandmarkRemarks(text: String, completion: @escaping () -> Void) {
        filteredLandmarkRemark.removeAll()
       
        //first search for username and then contained text...
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
                self.searchLandmarkRemarksWithContainedText(text: text)
                completion()
            }
        })
    }
    
    //TODO: To be changed(currently firestore does not provide support for text search). Because of the firestore limitation, for now, we will get all landmark remarks and search within that locally...
    private func searchLandmarkRemarksWithContainedText(text: String) -> Void {
        filteredLandmarkRemark = allLandMarkRemarks.filter {
            ($0.remark.lowercased().contains(text.lowercased()))
        }
    }
    
    private func getAllLandmarkRemarks() {
        allLandMarkRemarks.removeAll()
        Utilities.getAllDocuments(completionHandler: {(error,arrayOfDicts) in
            do {
                let json = try JSONSerialization.data(withJSONObject: arrayOfDicts)
                let decoder = JSONDecoder()
                let decodedRemarks = try decoder.decode([LandmarkRemark].self, from: json)
                self.allLandMarkRemarks = decodedRemarks
            } catch {
            }
        })
    }

}
