//
//  Checker.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 12.05.2022.
//

import Foundation
class Checker {
    static let shared = Checker()
    
    private let login = "Слон редкий"
    private let pswd = "пароль"
    
    private init(){}
    
    func check(login: String, pswd: String) -> Bool {
        guard login.hash == self.login.hash, pswd.hash == self.pswd.hash else { return false }
        print(#function)
        return true
    }
}
