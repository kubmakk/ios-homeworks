//
//  RealmCoordinator.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 09.11.2022.
//

import Foundation
import RealmSwift

final class RealmCoordinator {
    
    private let backgroundQueue = DispatchQueue(label: "RealmContext", qos: .background)
    private let mainQueue = DispatchQueue.main
    
    private func safeWrite(in realm: Realm, _ block: (() throws -> Void)) throws {
        realm.isInWriteTransaction
        ? try block()
        : try realm.write(block)
    }
}

extension RealmCoordinator: DatabaseCoordinatable {
    
    func checkIsAuthorised(completion: @escaping (Result<Success, DatabaseError>) -> Void) {
        do {
            let realm = try! Realm()
                // Create realm pointing to default file
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            let findTrue = realm.objects(AuthorizationModel.self).filter("isAuthorized == true")
            guard findTrue.count != 0 else {
                    completion(.failure(.error(desription: "Экран Авторизации")))
                    return
                }
                completion(.success(.save))
        } catch {
            completion(.failure(.error(desription: "Fail to create object in storage")))
        }
    }
    
    func check(checkModel: AuthorizationModel, completion: @escaping (Result<Success, DatabaseError>) -> Void) {
        do {
            let realm = try! Realm()
                // Create realm pointing to default file
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            
            let findUser = realm.object(ofType: AuthorizationModel.self, forPrimaryKey: checkModel.email)
            guard findUser != nil, findUser?.password != checkModel.password else {
                guard findUser != nil, findUser?.password == checkModel.password else {
                    completion(.failure(.error(desription: "Нужна регистрация")))
                    return
                }
                checkModel.isAuthorized.toggle()
                try! realm.write {
                    realm.add(checkModel, update: .modified)
                }
                completion(.success(.save))
                return
            }
            completion(.failure(.error(desription: "Не верный пароль!")))
            
        } catch {
            completion(.failure(.error(desription: "Fail to create object in storage")))
        }
    }
    func create<T>(_ model: T.Type, createModel: AuthorizationModel, completion: @escaping (Result<Success, DatabaseError>) -> Void) where T : Storable {
        do {
            let realm = try! Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            let findUser = realm.object(ofType: AuthorizationModel.self, forPrimaryKey: createModel.email)
            guard findUser != nil else {
                try! realm.write {
                    realm.add(createModel, update: .all)
                }
                createModel.isAuthorized.toggle()
                try! realm.write {
                    realm.add(createModel, update: .modified)
                }
                completion(.success(.save))
                return
            }
            completion(.failure(.error(desription: "Такой пользователь зарегистрирован")))
            
        } catch {
            completion(.failure(.error(desription: "Fail to create object in storage")))
        }
    }
}

