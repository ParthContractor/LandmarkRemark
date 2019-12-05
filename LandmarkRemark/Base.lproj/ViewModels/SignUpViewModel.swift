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
    
    // MARK: - Required textfield validations
     func validateTextFields(username: String?, email: String?, password: String?) -> String? {
        // Check that all fields are filled in
        if  username?.trimmingCharacters(in: .whitespacesAndNewlines) == String() ||
            email?.trimmingCharacters(in: .whitespacesAndNewlines) == String() ||
            password?.trimmingCharacters(in: .whitespacesAndNewlines) == String() {
            return "Please fill all fields."
        }
        
        if Utilities.isValidUsername(username!) == false {
            return "Username cannot be greater than 10 characters."
        }
        
        if Utilities.isValidEmailID(email!) == false {
            return "Please enter valid email."
        }
        
        if Utilities.isPasswordValid(password!) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    // MARK: - Create user service call follwed by commit display name
    func createUser(username: String?, email: String?, password: String?, completionHandler: @escaping () -> Void) {
        error = nil
        
        if let errorString = validateTextFields(username: username, email: email, password: password){
            error = errorString
            completionHandler()
            return
        }
        
        let group = DispatchGroup()
        DispatchQueue.global().async {
        group.enter()
        Utilities.ifUserNameAlreadyExists(username!, completion: {(exists) in
            if exists {
                self.error = "Username already exists."
                completionHandler()
            }
            else{
                // Create the user
                Auth.auth().createUser(withEmail: email!, password: password!) { (result, err) in
                    
                    // Check for errors
                    if err != nil {
                        // There was an error creating the user
                        self.error = err?.localizedDescription ?? "There was an error while user registration"
                        completionHandler()
                    }
                    else {
                        // User was created successfully, now store the username
                        let user = result!.user
                        let request = user.createProfileChangeRequest()
                        request.displayName = username
                        request.commitChanges(completion: { (err) in
                            self.error = nil//no need to handle error because, user is created however only display name is not inserted with associated user..
                            completionHandler()
                        })
                    }
                }
            }
            group.leave()
        })
        group.wait()
        }
    }
    
}
