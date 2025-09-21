//
//  TestUserService.swift
//  Navigation
//
//  Created by kubmakk on 11.01.2025.
//
import UIKit

class TestUserService: UserService {
    
    private var testUser: User
    
    init() {
        let avatar = UIImage(named: "teo")!
        self.testUser = User(login: "Varvara", fullName: "Leonard Test", avatar: avatar, status: "In work")
    }
    
    func getUser(by login: String) -> User? {
        return testUser
    }
}
