//
//  LandingScreenViewModel.swift
//  LandmarkRemark
//
//  Created by Parth on 01/12/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation

class LandingScreenViewModel {
    let navigationBarTitle: String
    let signUpButtonTitle: String
    let loginButtonTitle: String

    init() {
        self.navigationBarTitle = "Landmark Remark"
        self.signUpButtonTitle = "Sign Up"
        self.loginButtonTitle = "Login"
    }
}
