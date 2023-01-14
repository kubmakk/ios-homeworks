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
    var coreDataCoordinator: DatabaseCoordinatable { get }
}

final class CreateService: CreateServiceProtocol {
    
    static let shared: CreateServiceProtocol = CreateService()
    
    var coreDataCoordinator: DatabaseCoordinatable
    
    private init() {
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
