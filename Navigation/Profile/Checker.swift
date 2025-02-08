//
//  Checker.swift
//  Navigation
//
//  Created by kubmakk on 13.01.2025.
//

import Foundation

class Checker {
    static let shared = Checker()
    
    private let login = "111"
    private let password = "111"
    
    private init() {}
    
    func check(login: String, password: String) -> Bool {
        login == self.login && password == self.password
    }
}

protocol LoginViewControllerDelegate{
    func check(login: String, password: String) -> Bool
}

struct LoginInspector: LoginViewControllerDelegate{
    func check(login: String, password: String) -> Bool{
        return Checker.shared.check(login: login, password: password)
    }

}

protocol LoginFactory{
    func makeLoginInspector() -> LoginViewControllerDelegate
}

struct MyLoginFactory: LoginFactory{
    func makeLoginInspector() -> LoginViewControllerDelegate {
        return LoginInspector()
    }
    
    
}
