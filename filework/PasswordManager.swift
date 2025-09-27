//
//  PasswordManager.swift
//  filework
//
//  Created by kubmakk on 24/9/25.
//

import Foundation
import KeychainAccess

class PasswordManager{
    static var shared = PasswordManager()
    
    private let keychain = Keychain(service: "dassssd")
    private let passKey = "user_password"
    
    private init() {}
    
    var isPasswordSet: Bool {
        return (try? keychain.get(passKey)) != nil
    }
    
    func save(password: String) throws {
        try keychain.set(password, key: passKey)
    }
    
    func check(password: String) -> Bool {
        guard let savedPassword = try? keychain.get(passKey) else {
            return false
        }
        return password == savedPassword
    }
    
    func deletePassword() throws {
        try keychain.remove(passKey)
    }
    
    
    
}
