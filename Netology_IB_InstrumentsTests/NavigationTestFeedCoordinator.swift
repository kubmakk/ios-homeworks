//
//  NavigationTestFeedCoordinator.swift
//  Netology_IB_InstrumentsTests
//
//  Created by ALEKSANDR POZDNIKIN on 14.01.2023.
//

import XCTest
@testable import Netology_IB_Instruments

final class NavigationTestFeedCoordinator: XCTestCase {
    var sut: Coordinator!
    var navigationController: UINavigationControllerMock!
    var viewController: FeedViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = UINavigationControllerMock()
        viewController = FeedViewController()
        sut = FeedCoordinator(navigationController: navigationController)
        
    }

    override func tearDownWithError() throws {

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
