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
    //let name = NSLocalizedString("Слон Балдахин", comment: "Имя")
    let user = User(fullName: NSLocalizedString("Слон Балдахин", comment: "Имя"), avatar: "elephant.jpg", status: "Люблю рыбий жир")
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
        navigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
        navigationController.pushViewController(profileVC, animated: true)
    }
}
