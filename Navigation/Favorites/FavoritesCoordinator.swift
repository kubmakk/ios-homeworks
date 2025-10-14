//
//  FavoritesCoordinator.swift
//  Navigation
//
//  Created by kubmakk on 2/10/25.
//

import UIKit

final class FavoritesCoordinator: BaseCoordinator {
    override func start() {
        let vc = FavoritesViewController()
        navigationController.setViewControllers([vc], animated: false)
    }
}



