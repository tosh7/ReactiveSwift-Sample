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
    var isValidated: SignalProducer<Bool, Never> { get }
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

final class LoginViewModel: LoginViewModelInputs, LoginViewModelOutputs, LoginViewModelType {

    init() {
        userNameValidationSignal = userNameTextFiledDidChangeProperty.signal
            .map { userName -> LoginValidation in
                return userName.isEmail ? .success : .fail(error: "正しいユーザーネームではありません")
            }

        passwordValidationSignal = passwordTextFieldProperty.signal
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

        isValidated = SignalProducer.combineLatest(
            userNameTextFiledDidChangeProperty.producer,
            passwordTextFieldProperty.producer
        )
        .map { (userName, password) -> Bool in
            return userName.isEmail && password.isPassword
        }
    }

    private let userNameTextFiledDidChangeProperty = MutableProperty("")
    func userNameTextFieldDidChange(userName: String) {
        userNameTextFiledDidChangeProperty.value = userName
    }

    private let passwordTextFieldProperty = MutableProperty("")
    func passwordTextFieldDidChange(password: String) {
        passwordTextFieldProperty.value = password
    }

    let userNameValidationSignal: Signal<LoginValidation, Never>
    let passwordValidationSignal: Signal<LoginValidation, Never>
    let isValidated: SignalProducer<Bool, Never>

    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
}
