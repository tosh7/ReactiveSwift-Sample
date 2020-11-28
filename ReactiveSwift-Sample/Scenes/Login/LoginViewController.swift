//
//  LoginViewController.swift
//  ReactiveSwift-Sample
//
//  Created by Satoshi Komatsu on 2020/11/28.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

enum LoginValidation {
    case success
    case fail(error: String)
}

final class LoginViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!

    private let viewModel = LoginViewModel()

    override func viewDidLoad() {
        bindings()
    }

    private func bindings() {
        // Inputs
        userNameTextField.reactive.continuousTextValues
            .filter { !$0.isEmpty }
            .observeValues(viewModel.inputs.userNameTextFieldDidChange(userName:))

        passwordTextField.reactive.continuousTextValues
            .filter { !$0.isEmpty }
            .observeValues(viewModel.inputs.passwordTextFieldDidChange(password:))

        loginButton.reactive.controlEvents(.touchUpInside)
            .observeValues { [weak self] _ in
                self?.performSegue(withIdentifier: "loginToHome", sender: nil)
            }

        // Outputs
        viewModel.outputs.userNameValidationSignal.observeValues { userNameValidation in
            switch userNameValidation {
            case .success:
                print("成功")
            case let .fail(errorCode):
                print(errorCode)
            }
        }

        viewModel.outputs.isValidated.startWithValues { [weak self] isValidated in
            self?.loginButton.isEnabled = isValidated
            self?.loginButton.alpha = isValidated ? 1 : 0.5
        }
    }
}
