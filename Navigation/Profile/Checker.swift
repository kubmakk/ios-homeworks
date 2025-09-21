//
//  Checker.swift
//  Navigation
//
//  Created by kubmakk on 13.01.2025.
//

import Foundation
import FirebaseAuth

final class CheckerService: CheckerServiceProtocol {
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                if let errCode = AuthErrorCode(rawValue: error._code), errCode == .userNotFound {
                    print("Пользователь не найден, пытаемся зарегистрировать...")
                    self.signUp(email: email, password: password, completion: completion)
                } else {
                    completion(.failure(error))
                }
                return
            }
            print("Успешный вход существующего пользователя.")
            completion(.success(true))
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                print("Успешная регистрация нового пользователя.")
                completion(.success(true))
            }
        }
    }
}
