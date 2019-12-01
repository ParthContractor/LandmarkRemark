//
//  SignUpViewModel.swift
//  LandmarkRemark
//
//  Created by Parth on 01/12/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation
import Firebase

class SignUpViewModel {
    let navigationBarTitle: String
    let signUpButtonTitle: String
    let userNameTextFieldPlaceHolder: String
    let emailTextFieldPlaceHolder: String
    let passwordTextFieldPlaceHolder: String

    var error: String?

    init() {
        self.navigationBarTitle = "Sign Up"
        self.signUpButtonTitle = "Sign Up"
        self.userNameTextFieldPlaceHolder = "Username*"
        self.emailTextFieldPlaceHolder = "Email ID*"
        self.passwordTextFieldPlaceHolder = "Password*"
    }
    
    // Check if all textfields are filled and validate input.
    private func validateTextFields(username: String?, email: String?, password: String?) -> String? {
        // Check that all fields are filled in
        if  username?.trimmingCharacters(in: .whitespacesAndNewlines) == String() ||
            email?.trimmingCharacters(in: .whitespacesAndNewlines) == String() ||
            password?.trimmingCharacters(in: .whitespacesAndNewlines) == String() {
            return "Please fill all fields."
        }
        
        if Utilities.isValidEmailID(email!) == false {
            return "Please enter valid email."
        }
        
        if Utilities.isPasswordValid(password!) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    func createUser(username: String?, email: String?, password: String?, completionHandler: @escaping () -> Void) {
        error = nil
        
        if let errorString = validateTextFields(username: username, email: email, password: password){
            error = errorString
            completionHandler()
        }
        // Create the user
        Auth.auth().createUser(withEmail: email!, password: password!) { (result, err) in
            
            // Check for errors
            if err != nil {
                // There was an error creating the user
                self.error = err?.localizedDescription ?? "There was an error while user registration"
                completionHandler()
            }
            else {
                // User was created successfully, now store the first name and last name
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["username":username!,"uid": result!.user.uid ]) { (error) in
                    
                    if error != nil {
                        // No error handling for this because we do not have UI/req for user rofile update for now; assuming user details(e.e username will be associated with this user in firestore)
                    }
                }
                self.error = nil
                completionHandler()
            }
        }
    }
    
}
