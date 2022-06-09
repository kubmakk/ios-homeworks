//
//  FeedCoordinator.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 06.06.2022.
//

import Foundation
import UIKit

class FeedCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    lazy var feedViewModel = FeedViewModel(nav: self)
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    func start() {
        let feedVC = FeedViewController()
        feedVC.viewModel = feedViewModel
        feedVC.coordinator = self
        navigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "atom"), tag: 0)
        navigationController.view.backgroundColor = .yellow
        navigationController.pushViewController(feedVC, animated: true)
    }
    deinit {
        print("FeedCoordinator Deinit")
    }
}
extension FeedCoordinator: FeedNavigation {
    func push() {
        let coordinator = PostCoordinator(navigationController: navigationController)
        coordinator.start()
    }
    func pop() {
        let coordinator = PostCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
