//
//  MainCoordinator.swift
//  Navigation
//
//  Created by kubmakk on 30.03.2025.
//

import UIKit

enum AppFlow {
    case feed
    case profile
    case login
}

class MainCoordinator: MainBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
}
