//
//  LocalAuthorizationService.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 18.01.2023.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService {

    enum LASError: Error {
        case error(LAError)
    }
    enum Done {
        case success
    }

    let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
    var context = LAContext()
    var biometryType = LABiometryType.none

    func authorizeIfPossible(_ authorizationFinished: @escaping (Result<Done,LASError>) -> Void) {

        var error: NSError?
        let canUseBiometrics = context.canEvaluatePolicy(policy, error: &error)
        
        if let error = error as? LAError {
            print(error)
        }
            guard canUseBiometrics else {
                authorizationFinished(.failure(.error(error as! LAError)))
                return
            }
            context.evaluatePolicy(
                policy,
                localizedReason: "Авторизуйтесь для входа") { success, error in
                    
                    if let error = error as? LAError {
                        print(error)
                        authorizationFinished(.failure(.error(error)))
                        return
                    }
                    if success {
                        authorizationFinished(.success(.success))
                    } else {
                        print("Что то пошло не так")
                        authorizationFinished(.failure(.error(error as! LAError)))
                    }
                }
    }
    func checkBiometricType() -> Int {
        var error: NSError?
        let canUseBiometrics = context.canEvaluatePolicy(policy, error: &error)
        if #available(iOS 11.0, *) {
            if (context.biometryType == LABiometryType.faceID) {
                biometryType = .faceID
                print("FaceId support")
            } else if (context.biometryType == LABiometryType.touchID) {
                biometryType = .touchID
                print("TouchId support")
            } else {
                biometryType = .none
                print("No Biometric support")
            }
        } else {
            print("Fallback on earlier versions")
        }
        let biometry = context.biometryType
        return biometry.rawValue
    }
}
