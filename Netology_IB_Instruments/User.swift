//
//  User.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 03.05.2022.
//

import Foundation
import UIKit

protocol UserService {
    func getName(name: String) -> User?
}
class User {
    let fullName: String
    let avatar: String
    let status: String
    init(fullName: String, avatar: String, status: String){
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}
class CurrentUserService: UserService {
    private var user: User
    init(user: User){
        self.user = user
    }
    func getName(name: String) -> User? {
        guard user.fullName == name else { return nil }
        return user
    }
}
class TestUserService: UserService {
    private let user = User(fullName: "Панда Жуи", avatar: "panda", status: "Ем бамбук")
    func getName(name: String) -> User? {
        return user
    }
    
    
}
