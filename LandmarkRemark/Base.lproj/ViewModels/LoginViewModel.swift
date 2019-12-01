//
//  LoginViewModel.swift
//  LandmarkRemark
//
//  Created by Parth on 01/12/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation
import Firebase

class LoginViewModel {
    let navigationBarTitle: String
    let loginButtonTitle: String
    let emailTextFieldPlaceHolder: String
    let passwordTextFieldPlaceHolder: String
    
    var error: String?

    init() {
        self.navigationBarTitle = "Login"
        self.loginButtonTitle = "Login"
        self.emailTextFieldPlaceHolder = "Email ID"
        self.passwordTextFieldPlaceHolder = "Password"
    }
    
    // Check if all textfields are filled and validate input.
     func validateTextFields(email: String?, password: String?) -> String? {
        // Check that all fields are filled in
        if  email?.trimmingCharacters(in: .whitespacesAndNewlines) == String() ||
            password?.trimmingCharacters(in: .whitespacesAndNewlines) == String() {
            return "Please enter both email ID and password"
        }
        
        if Utilities.isValidEmailID(email!) == false {
            return "Please enter valid email."
        }
        
        if Utilities.isPasswordValid(password!) == false {
            return "Please enter valid password."
        }
        
        return nil
    }
    
    func login(email: String?, password: String?, completionHandler: @escaping () -> Void) {
        error = nil
        if let errorString = validateTextFields(email: email, password: password){
            error = errorString
            completionHandler()
        }
        // Signing in the user
        Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
            if error != nil {
                // Couldn't sign in
                self.error = error?.localizedDescription ?? "There was an error while login"
                completionHandler()
            }
            else {
                // Redirect to the home screen
                self.error = nil
                completionHandler()
            }
        }
    }

}
