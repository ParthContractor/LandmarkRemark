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

}
