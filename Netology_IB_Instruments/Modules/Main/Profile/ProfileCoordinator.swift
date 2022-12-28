//
//  ProfileCoordinator.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 04.06.2022.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    
    let user = User(fullName: NSLocalizedString("Elephant", comment: "Person name"), avatar: "elephant.jpg", status: NSLocalizedString("I love fish oil", comment: "Person status"))
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    lazy var profileViewModel = ProfileViewModel(nav: self)
    let databaseCoordinator = CreateService.shared.coreDataCoordinator
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    func start() {
        goToProfile()
    }
}
extension ProfileCoordinator: ProfileNavigation {
    func push() {
    }
    func pop() {
    }
    func goToProfile() {
        var profileVC = ProfileViewController(userServise: CurrentUserService(user: self.user), name: self.user.fullName, databaseCoordinator: databaseCoordinator)
#if DEBUG
        profileVC = ProfileViewController(userServise: TestUserService(), name: "name", databaseCoordinator: databaseCoordinator)
#endif
        profileVC.viewModel = ProfileViewModel(nav: self)
        profileVC.coordinator = self
        navigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("Profile", comment: "Name TabBarItem"), image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        navigationController.pushViewController(profileVC, animated: true)
    }
}
