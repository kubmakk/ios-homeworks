//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by kubmakk on 20.01.2025.
//


protocol LoginViewControllerDelegate{
    func check(login: String, password: String) -> Bool
}

struct LoginInspector: LoginViewControllerDelegate{
    func check(login: String, password: String) -> Bool{
        return Checker.shared.check(login: login, password: password)
    }

}