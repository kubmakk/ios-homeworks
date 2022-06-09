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
    
    deinit {
        print("Deinit login")
    }
}
