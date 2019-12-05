//
//  Utilities+Firestore.swift
//  LandmarkRemark
//
//  Created by Parth on 02/12/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation
import Firebase

extension Utilities {
    static let firestoreDB = Firestore.firestore()
    
    static func createDocument(collection : String = AppConstants.firestore_notes_collection_name, dictionaryData: [String:Any], completionHandler: @escaping (_ error:Error?) -> Void) {
        Utilities.firestoreDB.collection(collection)
            .addDocument(data: dictionaryData){ (error) in
                completionHandler(error)
        }
    }
    
    static func updateDocument(collection : String = AppConstants.firestore_notes_collection_name, documentID : String, dictionaryData: [String:Any], completionHandler: @escaping (_ error:Error?) -> Void) {
        Utilities.firestoreDB.collection(collection)
            .document(documentID)
            .setData(dictionaryData)
            { (error) in
                completionHandler(error)
        }
    }
    
    static func deleteDocument(collection : String = AppConstants.firestore_notes_collection_name, documentID : String, completionHandler: @escaping (_ error:Error?) -> Void) {
        Utilities.firestoreDB.collection(collection)
            .document(documentID)
            .delete
            { (error) in
                completionHandler(error)
        }
    }
    
    static func readDocument(collection : String = AppConstants.firestore_notes_collection_name, documentID : String, completionHandler: @escaping (_ error:Error?, _ documentData: [String : Any]? ) -> Void) {
        Utilities.firestoreDB.collection(collection)
            .document(documentID)
            .getDocument
            { (document, error) in
                if error == nil {
                    if let doc = document, doc.exists {
                        let documentData = doc.data()
                        completionHandler(error, documentData)
                    }
                    else{
                        completionHandler(nil, nil)//such scenario highly unlikely to occur..
                    }
                }
                else{
                    completionHandler(error, nil)
                }
        }
    }
    
    static func getAllDocuments(collection : String = AppConstants.firestore_notes_collection_name, completionHandler: @escaping (_ error:Error?, _ documentsDataArray: Array<[String : Any]> ) -> Void) {
        
        Utilities.firestoreDB.collection(collection)
            .getDocuments
            { (snapshot, error) in
                
                var arryToReturn = Array<[String : Any]>()
                if error == nil && snapshot != nil {
                    for document in snapshot!.documents {
                        var dataDict = document.data()
                        dataDict["ID"] = document.documentID
                        arryToReturn.append(dataDict)
                    }
                }
                completionHandler(error, arryToReturn)
        }
    }
    
    static func filterDocumentsWithFieldValue(fieldName: String, fieldValue: String, collection: String = AppConstants.firestore_notes_collection_name , completionHandler: @escaping (_ error:Error?, _ documentsDataArray: Array<[String : Any]> ) -> Void) {
        Utilities.firestoreDB.collection(AppConstants.firestore_notes_collection_name).whereField(fieldName, isEqualTo: fieldValue).getDocuments
            { (snapshot, error) in
                
                var arryToReturn = Array<[String : Any]>()
                if error == nil && snapshot != nil {
                    for document in snapshot!.documents {
                        let dataDict = document.data()
                        arryToReturn.append(dataDict)
                    }
                }
                completionHandler(error, arryToReturn)
        }
    }
}
