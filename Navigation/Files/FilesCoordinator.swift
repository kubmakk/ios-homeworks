//
//  FilesCoordinator.swift
//  Navigation
//
//  Created by kubmakk on 18/9/25.
//

import UIKit
import StorageService

class FilesCoordinator: BaseCoordinator {
    override func start() {
        let filesVC = filesViewController()
        filesVC.coordinator = self
        navigationController.pushViewController(filesVC, animated: false)
    }
}
