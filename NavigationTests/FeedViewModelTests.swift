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
    
    // Тест 1: Проверка, что updateStatus обновляет statusUser
    func testUpdateStatus_UpdatesStatusUser() throws {
        // Given
        let newStatus = "New Status"
        
        // When
        viewModel.updateStatus(newStatus: newStatus)
        
        // Then
        XCTAssertEqual(viewModel.statusUser, newStatus, "statusUser должен быть обновлен")
    }
    
    // Тест 2: Проверка, что updateStatus вызывает closure updatedIfNeed
    func testUpdateStatus_CallsUpdatedIfNeedClosure() throws {
        // Given
        let newStatus = "Updated Status"
        let expectation = self.expectation(description: "updatedIfNeed closure should be called")
        var receivedStatus: String?
        
        viewModel.updatedIfNeed = { status in
            receivedStatus = status
            expectation.fulfill()
        }
        
        // When
        viewModel.updateStatus(newStatus: newStatus)
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedStatus, newStatus, "Closure должен получить новый статус")
    }
    
    // Тест 3: Проверка, что updateStatus работает с пустой строкой
    func testUpdateStatus_HandlesEmptyString() throws {
        // Given
        let emptyStatus = ""
        let expectation = self.expectation(description: "updatedIfNeed closure should be called")
        var receivedStatus: String?
        
        viewModel.updatedIfNeed = { status in
            receivedStatus = status
            expectation.fulfill()
        }
        
        // When
        viewModel.updateStatus(newStatus: emptyStatus)
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.statusUser, emptyStatus, "statusUser должен быть обновлен на пустую строку")
        XCTAssertEqual(receivedStatus, emptyStatus, "Closure должен получить пустую строку")
    }
}

