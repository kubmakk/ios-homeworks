//
//  UserService.swift
//  Navigation
//
//  Created by kubmakk on 2/2/26.
//

import Foundation

protocol UserService {
    func getUser(by login: String) -> User?
}
