//
//  ProfileCoord.swift
//  Navigation
//
//  Created by kubmakk on 31.03.2025.
//

import UIKit


class ProfileCoordinator: BaseCoordinator {
    override func start() {
        let profileVC = ProfileViewController()
        profileVC.coordinator = self
        navigationController.pushViewController(profileVC, animated: false)
    }
    
    func showPhotos() {
        let photosVC = PhotosViewController()
        navigationController.pushViewController(photosVC, animated: true)
    }
}
