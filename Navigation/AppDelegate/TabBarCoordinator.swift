//
//  TabBarCoordinator.swift
//  Navigation
//
//  Created by kubmakk on 31.03.2025.
//

import UIKit

final class TabBarCoordinator: BaseCoordinator {
    let tabBarController = UITabBarController()
    
    override func start() {
        let feedCoordinator = FeedCoordinator(navigationController: UINavigationController())
        
    }
    
}
