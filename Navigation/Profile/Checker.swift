//
//  Checker.swift
//  Navigation
//
//  Created by kubmakk on 13.01.2025.
//

import Foundation
import FirebaseAuth

class CheckerService: CheckerServiceProtocol{
    
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                
                if let errCode = AuthErrorCode(rawValue: error._code){
                    switch errCode {
                    case .userNotFound:
                        
                        self.signUp(email: email, password: password, completion: completion)
                    default:
                        
                        completion(.failure(error))
                    }
                } else {
                    
                }
            }
            
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
            
                completion(.failure(error))
            } else {
                
                completion(.success(true))
            }
        }
    }
}
