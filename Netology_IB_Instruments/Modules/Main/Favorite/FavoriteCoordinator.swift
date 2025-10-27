//
//  FavoriteCoordinator.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 15.11.2022.
//

import Foundation
import UIKit

class FavoriteCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    let databaseCoordinator = CreateService.shared.coreDataCoordinator
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    lazy var favoriteViewModel = FavoriteViewModel(nav: self)
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    func start() {
        
        let favoriteVC = FavoriteViewController(databaseCoordinator: databaseCoordinator)
        favoriteVC.viewModel = favoriteViewModel
        favoriteVC.coordinator = self
        
        navigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("Favorites", comment: "Name TabBarItem"),image: UIImage(systemName: "star"),selectedImage: UIImage(systemName: "star.fill"))
//        var navItem = navigationController.navigationItem
//        var button = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(action))
//        navItem.rightBarButtonItem = button
//        button.title = ""
//        button.target = self
//        button.action = #selector(action)
        navigationController.pushViewController(favoriteVC, animated: true)
    }
    //    func delAll() {

    //    }
    deinit {
        print("FavoriteCoordinator Deinit")
    }
    func action (view: FavoriteViewController) {
        print("action")
        view.coordinator?.databaseCoordinator.deleteAll(PostCoreDataModel.self, completion: { _ in
        })
        view.state = .empty
        view.tableView.reloadData()
    }
    
}
extension FavoriteCoordinator: FavoriteNavigation {
    func push() {
        print("Push")
        let favoriteCoordiator = FavoriteCoordinator(navigationController: navigationController)
        favoriteCoordiator.start()
    }
    func pop() {
        print("POP")
        self.navigationController.popViewController(animated: true)
    }
}
