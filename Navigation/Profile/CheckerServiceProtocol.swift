//
//  CheckerServiceProtocol.swift
//  Navigation
//
//  Created by kubmakk on 26.08.2025.
//


protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

// Протокол для делегата LoginViewController
protocol LoginViewControllerDelegate: AnyObject {
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}