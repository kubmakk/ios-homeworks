//
//  Netology_IB_InstrumentsTests.swift
//  Netology_IB_InstrumentsTests
//
//  Created by ALEKSANDR POZDNIKIN on 06.01.2023.
//

import XCTest
@testable import Netology_IB_Instruments

final class Netology_IB_InstrumentsTests: XCTestCase {
    var sut: LogInViewController!
    var dataBC = RealmCoordinator()

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LogInViewController(databaseCoordinator: dataBC)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testCurrentOpenController() {
        //givev что дано
        
        //when что произошло
        let bool = true//sut.isViewLoaded
        //then  какой результат должен получиться
        XCTAssert(bool, "Screen is not current")
        //XCTAssert
    }

}
