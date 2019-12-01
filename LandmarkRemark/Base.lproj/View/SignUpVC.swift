//
//  SignUpVC.swift
//  LandmarkRemark
//
//  Created by Parth on 30/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let viewModel = SignUpViewModel()
    
    let style: Style
    
    // MARK: - ViewController LifeCycle
    init(nibName:String, style: Style){
        self.style = style
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return style.preferredStatusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        applyStyle()
        setUpData()
    }
    
    // MARK: - Helper methods
    private func applyStyle() {
        view.backgroundColor = style.backgroundColor
        style.apply(to: signUpButton)
        style.apply(placeHolderText: viewModel.userNameTextFieldPlaceHolder, to: userNameTextField)
        style.apply(placeHolderText: viewModel.emailTextFieldPlaceHolder, to: emailTextField)
        style.apply(placeHolderText: viewModel.passwordTextFieldPlaceHolder, to: passwordTextField)
        passwordTextField.isSecureTextEntry = true
    }
    
    private func setUpData() {
        title = viewModel.navigationBarTitle
        signUpButton .setTitle(viewModel.signUpButtonTitle, for: .normal)
    }
    
    private func redirectToHomeScreen() {
        if viewModel.error == nil {
            self.presentAlert(withTitle: "Success", message: "redirectToHomeScreen")
        }
    }
    
    private func handleError() {
        if let error = self.viewModel.error {
            self.presentAlert(withTitle: "Error", message: error)
        }
    }

    // MARK: - Actions/Events
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        showLoadingIndicator(onView: view)
        viewModel.createUser(username: userNameTextField.text, email: emailTextField.text, password: passwordTextField.text, completionHandler:{
            DispatchQueue.main.async {
                //update UI
                self.removeLoadingIndicator()
                self.handleError()
                self.redirectToHomeScreen()
            }
        })
    }
}
