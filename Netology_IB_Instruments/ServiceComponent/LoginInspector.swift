//
//  LoginInspector.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 22.05.2022.
//

import Foundation

enum AuthModel {
    case login
    case signUp
}
enum NetworkError: Error {
    case noConnection
}
final class LoginInspector: LoginViewControllerDelegate {
    

    func checkCredentials(email: String, password: String, completion: @escaping (Result<AuthModel, NetworkError>) -> Void) {
         
        CheckerService.shared.checkCredentials(email: email, password: password) { result, error in
            guard error == nil else {
                completion(.failure(.noConnection))
                return
            }
            completion(.success(.login))
        }
    }
    
    func signUp(with email: String, password: String, completion: @escaping (Result<AuthModel, NetworkError>) -> Void) {
        CheckerService.shared.signUp(with: email, password: password) { result, error in
            guard error == nil else {
                completion(.failure(.noConnection))
                return
            }
            completion(.success(.signUp))
        }
    }
    
}
