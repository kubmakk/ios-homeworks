//
//  Netology_IB_InstrumentsTests.swift
//  Netology_IB_InstrumentsTests
//
//  Created by ALEKSANDR POZDNIKIN on 06.01.2023.
//

import XCTest
@testable import Netology_IB_Instruments

final class NavigationTests: XCTestCase {
    var sut: Coordinator!
    var navigationController: UINavigationControllerMock!
    var viewController: LogInViewController!
    var dataBC: DatabaseCoordinatable!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        dataBC = CreateService.shared.coreDataCoordinator
        viewController = LogInViewController(databaseCoordinator: dataBC)
        navigationController = UINavigationControllerMock()
        sut = AuthCoordinator(navigationController: navigationController)
        
    }

    override func tearDownWithError() throws {
        dataBC = nil
        viewController = nil
        navigationController = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testCurrentOpenController() {
        //given что дано
        
        //when что произошло
        sut.start()
        //then  какой результат должен получиться
        XCTAssertTrue(navigationController.pushViewControllerCalled)
    }

}

import UIKit

final class UINavigationControllerMock: UINavigationController {
    var pushViewControllerCalled = false
    override func pushViewController(
        _ viewController: UIViewController, animated: Bool
    ) {
        super.pushViewController(viewController, animated: animated)
        pushViewControllerCalled = true
    }
    
    var presentCalled = false
    override func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)? = nil
    ) {
        super.present(
            viewControllerToPresent, animated: flag, completion: completion
        )
        presentCalled = true
    }
}
