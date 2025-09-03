//
//  LoginProtocols.swift
//  Navigation
//
//  Created by kubmakk on 26.08.2025.
//

import Foundation

protocol CheckerServiceProtocol{
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

protocol LoginViewControllerDelegate{
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}
