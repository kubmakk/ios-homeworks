//
//  LoginViewModelTests.swift
//  NavigationTests
//
//  Created by kubmakk on 31/10/25.
//

import XCTest
@testable import Navigation

class LoginDelegateMock: LoginViewControllerDelegate {
    var fakeResult: Bool = false
    var checkCallCount: Int = 0
    var lastLogin: String?
    var lastPassword: String?
    
    func check(login: String, password: String) -> Bool {
        checkCallCount += 1
        lastLogin = login
        lastPassword = password
        return fakeResult
    }
}

final class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    var mockDelegate: LoginDelegateMock!
    
    override func setUpWithError() throws {
        super.setUp()
        mockDelegate = LoginDelegateMock()
        viewModel = LoginViewModel(loginDelegate: mockDelegate)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    //Проверка успешного логина
    func testCheck_SuccessfulLogin() throws {
        mockDelegate.fakeResult = true
        let expectation = self.expectation(description: "onLoginResult should be called with true")
        var receivedResult: Bool?
        
        viewModel.onLoginResult = { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        viewModel.check(login: "111", password: "111")
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(mockDelegate.checkCallCount, 1, "check должен быть вызван один раз")
        XCTAssertEqual(mockDelegate.lastLogin, "111", "Логин должен быть передан корректно")
        XCTAssertEqual(mockDelegate.lastPassword, "111", "Пароль должен быть передан корректно")
        XCTAssertEqual(receivedResult, true, "Результат должен быть true")
    }
    
    //Проверка неуспешного логина
    func testCheck_FailedLogin() throws {
        mockDelegate.fakeResult = false
        let expectation = self.expectation(description: "onLoginResult should be called with false")
        var receivedResult: Bool?
        
        viewModel.onLoginResult = { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        viewModel.check(login: "wrong", password: "wrong")
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(mockDelegate.checkCallCount, 1, "check должен быть вызван один раз")
        XCTAssertEqual(mockDelegate.lastLogin, "wrong", "Логин должен быть передан корректно")
        XCTAssertEqual(mockDelegate.lastPassword, "wrong", "Пароль должен быть передан корректно")
        XCTAssertEqual(receivedResult, false, "Результат должен быть false")
    }
    
    //Проверка с пустыми значениями
    func testCheck_EmptyCredentials() throws {
        mockDelegate.fakeResult = false
        let expectation = self.expectation(description: "onLoginResult should be called")
        var receivedResult: Bool?
        
        viewModel.onLoginResult = { result in
            receivedResult = result
            expectation.fulfill()
        }
        viewModel.check(login: "", password: "")
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(mockDelegate.checkCallCount, 1, "check должен быть вызван один раз")
        XCTAssertEqual(mockDelegate.lastLogin, "", "Логин должен быть пустой строкой")
        XCTAssertEqual(mockDelegate.lastPassword, "", "Пароль должен быть пустой строкой")
        XCTAssertEqual(receivedResult, false, "Результат должен быть false для пустых данных")
    }
}

