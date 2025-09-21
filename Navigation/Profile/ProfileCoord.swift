//
//  ProfileCoord.swift
//  Navigation
//
//  Created by kubmakk on 31.03.2025.
//

import UIKit


class LoginCoordinator: BaseCoordinator {
    override func start() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        loginVC.checkerService = CheckerService()
        navigationController.pushViewController(loginVC, animated: false)
    }
    
    func showPhotos() {
        let photosVC = PhotosViewController()
        navigationController.pushViewController(photosVC, animated: true)
    }
    
    func showProfile() {
        let profileVC = ProfileViewController()
        profileVC.coordinator = self
        navigationController.setViewControllers([profileVC], animated: true)
    }
}
