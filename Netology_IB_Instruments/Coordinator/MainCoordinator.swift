//
//  MainCoordinator.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 04.06.2022.
//

import Foundation
import UIKit

protocol MainCoordinator {
    func startApplication() -> UIViewController
}

final class MainCoordinatorImp: MainCoordinator {
    func startApplication() -> UIViewController {
        return MainTabBarViewController()
    }
}
