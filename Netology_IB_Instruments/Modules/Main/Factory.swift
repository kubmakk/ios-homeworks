//
//  Factory.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 07.06.2022.
//
import UIKit

final class Factory {
    enum State {
        case first
        case second
        case third
        case fourth
    }
    
    let navigationController: UINavigationController
    let state: State
    
    init(
        navigationController: UINavigationController,
        state: State
    ) {
        self.navigationController = navigationController
        self.state = state
        startModule()
    }
   private func startModule() {
        switch state {
        case .first:
            let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
            profileCoordinator.start()
        case .second:
            let feedCoordiator = FeedCoordinator(navigationController: navigationController)
            feedCoordiator.start()
        case .third:
            ()
        case .fourth:
            let loginCoordinator = AuthCoordinator(navigationController: navigationController)
            loginCoordinator.start()
        }
    }
}
