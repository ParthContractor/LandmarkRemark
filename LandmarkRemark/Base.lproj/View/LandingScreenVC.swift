//
//  LandingScreenVC.swift
//  LandmarkRemark
//
//  Created by Parth on 30/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit

class LandingScreenVC: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel = LandingScreenViewModel()
    
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
        
        applyStyle()
        setUpData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Helper methods
    private func applyStyle() {
        view.backgroundColor = style.backgroundColor
        style.apply(to: signUpButton)
        style.apply(to: loginButton)
    }
    
    private func setUpData() {
        title = viewModel.navigationBarTitle
        signUpButton .setTitle(viewModel.signUpButtonTitle, for: .normal)
        loginButton .setTitle(viewModel.loginButtonTitle, for: .normal)
    }
    
    // MARK: - Actions/Events
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let signUpVC = SignUpVC(nibName: "SignUpVC", style: .landmarkRemark)
        self.navigationController?.pushViewController(signUpVC, animated:true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let loginVC = LoginVC(nibName: "LoginVC", style: .landmarkRemark)
        self.navigationController?.pushViewController(loginVC, animated:true)
    }

}
