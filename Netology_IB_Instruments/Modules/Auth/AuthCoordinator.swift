//
//  AuthCoordinator.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 06.06.2022.
//

import Foundation
import UIKit

class AuthCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    lazy var loginViewModel = LoginViewModel(nav: self)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        //print("AuthCoordinator Start")
        goToLoginPage()
    }
    func goToLoginPage(){
        let coreDataCoordinator = CreateService.shared.coreDataCoordinator

        let loginVC = LogInViewController(databaseCoordinator: coreDataCoordinator)
        loginVC.viewModel = loginViewModel
        navigationController.pushViewController(loginVC, animated: true)
//        realmCoordinator.checkIsAuthorised { [weak self] result in
//            guard let strongSelf = self else { return }
//            switch result {
//            case .success(.save):
//                print("🍋 Find model")
//                strongSelf.goToHome()
//                //strongSelf.viewModel!.goToHome()
//            case .failure(let error):
//                strongSelf.navigationController.pushViewController(loginVC, animated: true)
//                print(error)
//            }
//        }
    }
}
extension AuthCoordinator: LoginNavigation {
    func goToRegisterPage() {
        
    }
    
    func goToHome() {
        print("goToHome")
        // Get the app coordinator
        let appC = parentCoordinator as! AppCoordinator
        // And go to home!
        appC.goToHome()
        // Remember to clean up
        parentCoordinator?.childDidFinish(self)
    }
    
    
}
