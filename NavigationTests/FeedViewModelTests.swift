//
//  FeedViewModelTests.swift
//  NavigationTests
//
//  Created by kubmakk on 31/10/25.
//

import XCTest
@testable import Navigation

final class FeedViewModelTests: XCTestCase {
    
    var viewModel: FeedVM!
    var userModel: UserModel!
    
    override func setUpWithError() throws {
        super.setUp()
        userModel = UserModel(fullName: "Test User", status: "Initial Status")
        viewModel = FeedVM(user: userModel, initialStatus: userModel.status)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        userModel = nil
        super.tearDown()
    }
    
    //Проверка, что updateStatus обновляет statusUser
    func testUpdateStatus_UpdatesStatusUser() throws {
        // Given
        let newStatus = "New Status"
        
        viewModel.updateStatus(newStatus: newStatus)
        
        XCTAssertEqual(viewModel.statusUser, newStatus, "statusUser должен быть обновлен")
    }
    
    func testUpdateStatus_CallsUpdatedIfNeedClosure() throws {
        let newStatus = "Updated Status"
        let expectation = self.expectation(description: "updatedIfNeed closure should be called")
        var receivedStatus: String?
        
        viewModel.updatedIfNeed = { status in
            receivedStatus = status
            expectation.fulfill()
        }
        

        viewModel.updateStatus(newStatus: newStatus)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedStatus, newStatus, "Closure должен получить новый статус")
    }
    
    //Проверка, что updateStatus работает с пустой строкой
    func testUpdateStatus_HandlesEmptyString() throws {
        let emptyStatus = ""
        let expectation = self.expectation(description: "updatedIfNeed closure should be called")
        var receivedStatus: String?
        
        viewModel.updatedIfNeed = { status in
            receivedStatus = status
            expectation.fulfill()
        }
        
        viewModel.updateStatus(newStatus: emptyStatus)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.statusUser, emptyStatus, "statusUser должен быть обновлен на пустую строку")
        XCTAssertEqual(receivedStatus, emptyStatus, "Closure должен получить пустую строку")
    }
}

