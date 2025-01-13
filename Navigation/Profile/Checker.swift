//
//  Checker.swift
//  Navigation
//
//  Created by kubmakk on 13.01.2025.
//

import UIKit

final class Checker {
    static let checker = Checker()
    
    private let login = "Kubmakk"
    private let password = "123"
    
    private init() {}
    
    func check(login: String, password: String) -> Bool {
        login == self.login && password == self.password
    }
}
