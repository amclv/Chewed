//
//  LoginViewController.swift
//  FoodieFun
//
//  Created by Aaron Cleveland on 2/5/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit
import GoogleMobileAds

class LoginViewController: ShiftableViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let auth = Auth()
    
    var window: UIWindow?
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        interstitial.load(request)
//        usernameTextField.delegate = self
//        passwordTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        print("Login Button Tapped")
        if let username = usernameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty {
            let user = User(username: username, password: password, email: "")
            
            auth.signIn(with: user) { (error) in
                if let error = error {
                    DispatchQueue.main.async {
                        Alert.showBasic(title: "Error Signing In", message: "Please check your login information!", vc: self)
                    }
                    print("Error occured during signin: \(error)")
                } else {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "loginShowTabbar", sender: nil)
                    }
                }
            }
        }
        if self.interstitial.isReady {
            self.interstitial.present(fromRootViewController: self)
        }
    }
}

extension LoginViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
