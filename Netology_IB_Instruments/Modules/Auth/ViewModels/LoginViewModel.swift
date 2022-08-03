//
//  LoginViewModel.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 08.06.2022.
//

import Foundation
protocol LoginNavigation : AnyObject{
    func goToRegisterPage()
    func goToHome()
}

class LoginViewModel {

    weak var navigation : LoginNavigation!
    
    enum Action {
        case isReady
        case isSignUp
    }
    enum State {
        case first
        case second
    }
    private(set) var state: State = .first {
        didSet {
            stateChanged?(state)
        }
    }
    var stateChanged: ((State) -> Void)?
    
    init(nav : LoginNavigation) {
        self.navigation = nav
    }
    
    func goToRegister(){
        navigation.goToRegisterPage()
    }
    
    func goToHome(){
        print("goToHome")
        navigation.goToHome()
    }
    
    func changeState(_ action: Action) {
        switch action {
        case .isReady:
            state = .second
        case .isSignUp:
            state = .first
        }
    }
    
    deinit {
        print("Deinit login")
    }
}
