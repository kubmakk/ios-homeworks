//
//  CreateService.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 16.11.2022.
//

import Foundation

enum CreateError: Error {
    case error(description: String)
}

protocol CreateServiceProtocol: AnyObject {
    //var realmCoordinator: DatabaseCoordinatable { get }
    var coreDataCoordinator: DatabaseCoordinatable { get }
    
    /// Миграция объектов из Realm в CoreData.
    //func migrateStorageModels(completion: @escaping (Result<Void, MigrationError>) -> Void)
}

final class CreateService: CreateServiceProtocol {
    
    static let shared: CreateServiceProtocol = CreateService()
    
    //let realmCoordinator: DatabaseCoordinatable
    var coreDataCoordinator: DatabaseCoordinatable
    
    private init() {
        //self.realmCoordinator = Self.createDatabaseCoordinator(for: .realm)
        self.coreDataCoordinator = Self.createDatabaseCoordinator()
    }
    
    private static func createDatabaseCoordinator() -> DatabaseCoordinatable {
            let bundle = Bundle.main
            guard let url = bundle.url(forResource: "DatabaseModel", withExtension: "momd") else {
                fatalError("Can't find DatabaseDemo.xcdatamodeld in main Bundle")
            }
            switch CoreDataCoordinator.create(url: url) {
            case .success(let database):
                return database
            case .failure:
                switch CoreDataCoordinator.create(url: url) {
                case .success(let database):
                    return database
                case .failure(let error):
                    fatalError("Unable to create CoreData Database. Error - \(error.localizedDescription)")
                }
            }
    }
}

/*extension MigrationService: MigrationServiceProtocol {
    
    func migrateStorageModels(completion: @escaping (Result<Void, MigrationError>) -> Void) {
        self.realmCoordinator.fetchAll(ArticleRealmModel.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articleObjects):
                guard !articleObjects.isEmpty else {
                    completion(.success(()))
                    return
                }
                
                let articles = articleObjects.map { News.Article(articleRealmModel: $0) }
                let keyedValues = self.keyedValues(from: articles)
                self.coreDataCoordinator.create(ArticleCoreDataModel.self, keyedValues: keyedValues) { result in
                    switch result {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(.error(description: error.localizedDescription)))
                    }
                }
            case .failure(let error):
                completion(.failure(.error(description: error.localizedDescription)))
            }
        }
    }
}
*/
