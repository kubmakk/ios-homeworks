//
//  LoginFactory.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 12.05.2022.
//

import Foundation
protocol LoginFactory {
    func inspector() -> LoginInspector
}

class LoginInspector: LoginViewControllerDelegate {
        
    func validation(login: String, pswd: String) -> Bool {
        print(#function)
        let check = Checker.shared.check(login: login, pswd: pswd)
        print(check)
        return check
    }
}

struct MyLogicFactory: LoginFactory {
    func inspector() -> LoginInspector {
        let inspector = LoginInspector()
        return inspector
    }
}
