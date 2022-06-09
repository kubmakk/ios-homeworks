//
//  PostCoordinator.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 08.06.2022.
//

import Foundation
import UIKit

class PostCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    func start() {
        let postVC = PostViewController()
        self.navigationController.pushViewController(postVC, animated: true)
    }
}
