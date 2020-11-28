//
//  LoginViewController.swift
//  ReactiveSwift-Sample
//
//  Created by Satoshi Komatsu on 2020/11/28.
//

import UIKit
import ReactiveSwift

enum LoginStatus {
    case success
    case fail(error: String)
}

final class LoginViewController: UIViewController {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    private var loginStatus: LoginStatus = .fail(error: "初期状態")
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        loginStatus = .success
        
    }
    
    @IBAction private func loginButtonTapped() {
        guard case .success = loginStatus else { return }
        
        performSegue(withIdentifier: "loginToHome", sender: nil)
    }
}
