//
//  NavigationTestProfileCoordinator.swift
//  Netology_IB_InstrumentsTests
//
//  Created by ALEKSANDR POZDNIKIN on 14.01.2023.
//

import XCTest
@testable import Netology_IB_Instruments

final class NavigationTestProfileCoordinator: XCTestCase {
    var sut: Coordinator!
    var navigationController: UINavigationControllerMock!
    var viewController: ProfileViewController!
    var dataBC: DatabaseCoordinatable!
    //var user: User!
    var userService: TestUserService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        userService = TestUserService()
        //user = User(fullName: NSLocalizedString("Elephant", comment: "Person name"), avatar: "elephant.jpg", status: NSLocalizedString("I love fish oil", comment: "Person status"))
        dataBC = CreateService.shared.coreDataCoordinator
        navigationController = UINavigationControllerMock()
        viewController = ProfileViewController(userServise: userService, name: "name", databaseCoordinator: dataBC)
        sut = ProfileCoordinator(navigationController: navigationController)
        
    }

    override func tearDownWithError() throws {
        userService = nil
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
