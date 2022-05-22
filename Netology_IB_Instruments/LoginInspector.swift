//
//  LoginInspector.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 22.05.2022.
//

import Foundation
class LoginInspector: LoginViewControllerDelegate {
    func validation(login: String, pswd: String) -> Bool {
        print(#function)
        let check = Checker.shared.check(login: login, pswd: pswd)
        print(check)
        return check
    }
}
