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
    //let user = User(fullName: "1", avatar: "elephant.jpg", status: "Люблю рыбий жир")
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    //lazy var profileViewModel = ProfileViewModel(nav: self)
    lazy var favoriteViewModel = FavoriteViewModel(nav: self)
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    func start() {
        
//        let profileVC = ProfileViewController(userServise: CurrentUserService(user: self.user), name: self.user.fullName)
//        profileVC.viewModel = ProfileViewModel(nav: self)
        //profileVC.coordinator = self
        
        let favoriteVC = FavoriteViewController(databaseCoordinator: databaseCoordinator)
        favoriteVC.viewModel = favoriteViewModel
        favoriteVC.coordinator = self
        favoriteVC.coordinator?.databaseCoordinator.deleteAll(PostCoreDataModel.self, completion: { _ in
        })
        navigationController.tabBarItem = UITabBarItem(title: "Favorites",image: UIImage(systemName: "star"),selectedImage: UIImage(systemName: "star.fill"))
        navigationController.pushViewController(favoriteVC, animated: true)
    }
    deinit {
        print("FavoriteCoordinator Deinit")
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
