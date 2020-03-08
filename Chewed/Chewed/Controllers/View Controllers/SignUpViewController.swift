//
//  SignUpViewController.swift
//  FoodieFun
//
//  Created by Aaron Cleveland on 2/4/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SignUpViewController: ShiftableViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    let auth = Auth()
    
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-8909349188310022/7152683552")
        let request = GADRequest()
        interstitial.load(request)
        emailTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        locationTextField.delegate = self
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        // perform signup operation
        print("Sign Up Button Tapped")
        if let username = usernameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty,
            let email = emailTextField.text,
            !email.isEmpty,
            let location = locationTextField.text,
            !location.isEmpty {
            let user = User(username: username, password: password, email: email, location: location)
            
            auth.signUp(with: user) { (error) in
                if let error = error {
                    print("Error occured during signup: \(error)")
                    if self.interstitial.isReady {
                        self.interstitial.present(fromRootViewController: self)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "signupShowTabbar", sender: self)
                    }
                }
            }
        }
        Alert.showBasic(title: "Oops!", message: "You didn't fill out a required field", vc: self)
    }
}

extension SignUpViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
