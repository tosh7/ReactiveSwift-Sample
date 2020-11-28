//
//  LoginViewModel.swift
//  ReactiveSwift-Sample
//
//  Created by Satoshi Komatsu on 2020/11/28.
//

import Foundation
import ReactiveSwift

protocol LoginViewModelInputs {
    func userNameTextFieldDidChange(userName: String)
    func passwordTextFieldDidChange(password: String)
}

protocol LoginViewModelOutputs {
    
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

final class LoginViewModel: LoginViewModelInputs, LoginViewModelOutputs, LoginViewModelType {
    
    init() {
        
    }
    
    func userNameTextFieldDidChange(userName: String) {
        
    }
    
    func passwordTextFieldDidChange(password: String) {
         
    }
    
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
}
