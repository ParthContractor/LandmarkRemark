//
//  LandmarkRemarkTests.swift
//  LandmarkRemarkTests
//
//  Created by Parth on 30/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import XCTest
@testable import LandmarkRemark

class LandmarkRemarkTests: XCTestCase {
    let uid = "95Iv97xaa5eVKyDclfJ9UYN3YRC2"
    let username = "puc5"
    let remark = "beautiful lake"
    let latitude = 32.0763
    let longitude = 155.9877
    let testCollection = "testCollection1"
    let testDocumentIDToUpdate = "4k2KdKhpua77S6oPsWVm"

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmailValidation(){
        var email = "puc1@yopmail.com"
        XCTAssertTrue(Utilities.isValidEmailID(email))
        email = "puc2@"
        XCTAssertFalse(Utilities.isValidEmailID(email))
        email = "puc2@sasasa."
        XCTAssertFalse(Utilities.isValidEmailID(email))
    }
    
    func testPasswordValidation(){
        var password = "@pucyopmail123"
        XCTAssertTrue(Utilities.isPasswordValid(password))
        password = "puc2"
        XCTAssertFalse(Utilities.isPasswordValid(password))
    }

    func testButtonStyling(){
        let style = Style.landmarkRemark
        let button = UIButton(type: .custom)
        style.apply(to: button)
        XCTAssertTrue(button.backgroundColor!.isEqual(UIColor.landmarkRemarkTheme))
        XCTAssertFalse((button.titleLabel?.textColor.isEqual(UIColor.landmarkRemarkTheme))!)
    }
    
    func testUserAlreadyExistsCheckWhileSignUp(){
        let viewModel = SignUpViewModel()
        XCTAssertNil(viewModel.error)
        let exp = expectation(description: "signUp")
        viewModel.createUser(username: "puc2", email: "puc2@yopmail.com", password: "puc2yopmail@", completionHandler: {
            exp.fulfill()
        })
        waitForExpectations(timeout: 7)
        XCTAssertNotNil(viewModel.error)
    }
    
    func testLoginValidateTextFields(){
        let viewModel = LoginViewModel()
        viewModel.error = viewModel.validateTextFields(email: "jh", password: "kjkj")
        XCTAssertEqual("Please enter valid email.", viewModel.error)
    }
    
    func testLoginWithRightCredentials(){
        let viewModel = LoginViewModel()
        XCTAssertNil(viewModel.error)
        let exp = expectation(description: "login")
        viewModel.login(email: "puc2@yopmail.com", password: "puc2yopmail@", completionHandler: {
            exp.fulfill()
        })
        waitForExpectations(timeout: 9)
        XCTAssertNil(viewModel.error)
    }
    
    func testLandingScreenViewModel(){
        let viewModel = LandingScreenViewModel()
        XCTAssertEqual("Landmark Remark", viewModel.navigationBarTitle)
        XCTAssertEqual("Sign Up", viewModel.signUpButtonTitle)
        XCTAssertEqual("Login", viewModel.loginButtonTitle)
    }
    
    func testCreateandReadFireStoreDocument() {
        var err: Error?
        var exp = expectation(description: "CreateNote")
        Utilities.createDocument(collection: testCollection, dictionaryData: [AppConstants.uidKey:uid, AppConstants.usernameKey:username, AppConstants.locationRemarkKey: remark, AppConstants.latitudeKey:latitude, AppConstants.longitudeKey:longitude], completionHandler: {(error) in
            err = error
            exp.fulfill()
        })
        waitForExpectations(timeout: 5)
        XCTAssertNil(err)
        err = nil
        
        exp = expectation(description: "ReadNote")
        Utilities.filterDocumentsWithFieldValue(fieldName: AppConstants.usernameKey, fieldValue: username, collection: testCollection, completionHandler: {(error, documentsArray) in
            err = error
            exp.fulfill()
        })
        waitForExpectations(timeout: 5)
        XCTAssertNil(err)

    }
    
    func testgetAllFirestoreTestingDocuments() {
        var err: Error?
        var arr = Array<[String : Any]>()
        let exp = expectation(description: "getDocuments")
        Utilities.getAllDocuments(collection: testCollection, completionHandler: { (error,arrayDocuments) in
            err = error
            arr = arrayDocuments
            exp.fulfill()
        })
        waitForExpectations(timeout: 5)
        XCTAssertNil(err)
        XCTAssertNotEqual(0,arr.count)
    }
    
    func testUpdateFireStoreDocument() {
        let length = 32
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomCharacters = (0..<length).map{_ in characters.randomElement()!}
        let randomString = String(randomCharacters)
        
        var err: Error?
        let exp = expectation(description: "updateDocument")
        Utilities.updateDocument(collection: testCollection, documentID: testDocumentIDToUpdate, dictionaryData:[AppConstants.uidKey:uid, AppConstants.usernameKey:username, AppConstants.locationRemarkKey: randomString, AppConstants.latitudeKey:latitude, AppConstants.longitudeKey:longitude], completionHandler: { (error) in
            err = error
            exp.fulfill()
        })
        waitForExpectations(timeout: 5)
        XCTAssertNil(err)
    }
    
    func testZDeleteFireStoreDocument() {//NOTE//FireSoft API always returns true even if it gets deleted once or documentID no longer exists
        let documentID = "ah3EUusmJBZ2TLClJxDI"
        var err: Error?
        let exp = expectation(description: "deleteDocument")
        Utilities.deleteDocument(collection: testCollection, documentID: documentID, completionHandler: { (error) in
            err = error
            exp.fulfill()
        })
        waitForExpectations(timeout: 5)
        XCTAssertNil(err)
    }

}
