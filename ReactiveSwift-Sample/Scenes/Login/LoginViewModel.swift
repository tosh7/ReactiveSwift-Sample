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
    var userNameValidationSignal: Signal<LoginValidation, Never> { get }
    var passwordValidationSignal: Signal<LoginValidation, Never> { get }
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

final class LoginViewModel: LoginViewModelInputs, LoginViewModelOutputs, LoginViewModelType {
    
    init() {
        userNameValidationSignal = userNameTextFiledDidChangeIO.output
            .map { userName -> LoginValidation in
                return userName.isEmail ? .success : .fail(error: "正しいユーザーネームではありません")
            }
        passwordValidationSignal = passwordTextFieldIO.output
            .map { password -> LoginValidation in
                var errorLog: String = ""
                
                if !password.hasCharactor {
                    errorLog += "英文字を使用してください\n"
                }
                if !password.hasNumber {
                    errorLog += "数字を使用してください\n"
                }
                if !password.eightDigit {
                    errorLog += "8文字以上にしてください"
                }
                
                if errorLog.count == 0 {
                    return .success
                } else {
                    return .fail(error: errorLog)
                }
            }
    }
    
    private let userNameTextFiledDidChangeIO = Signal<String, Never>.pipe()
    func userNameTextFieldDidChange(userName: String) {
        userNameTextFiledDidChangeIO.input.send(value: userName)
    }
    
    private let passwordTextFieldIO = Signal<String, Never>.pipe()
    func passwordTextFieldDidChange(password: String) {
        passwordTextFieldIO.input.send(value: password)
    }
    
    let userNameValidationSignal: Signal<LoginValidation, Never>
    let passwordValidationSignal: Signal<LoginValidation, Never>
    
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
}
