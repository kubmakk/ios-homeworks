//
//  Checker.swift
//  Navigation
//
//  Created by kubmakk on 13.01.2025.
//

import UIKit

class Checker {
    static let shared = Checker()
    
    private let login = "111"
    private let password = "111"
    
    private init() {}
    
    func check(login: String, password: String) -> Bool {
        login == self.login && password == self.password
    }
}
