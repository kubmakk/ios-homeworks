//
//  LoginVM.swift
//  Navigation
//
//  Created by kubmakk on 31.10.2025.
//

import Foundation

final class LoginViewModel {
    
    private let loginDelegate: LoginViewControllerDelegate
    
    var onLoginResult: ((Bool) -> Void)?
    
    init(loginDelegate: LoginViewControllerDelegate) {
        self.loginDelegate = loginDelegate
    }
    
    func check(login: String, password: String) {
        let result = loginDelegate.check(login: login, password: password)
        onLoginResult?(result)
    }
}

