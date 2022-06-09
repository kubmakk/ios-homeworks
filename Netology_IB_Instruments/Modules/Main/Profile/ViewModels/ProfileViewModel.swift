//
//  ProfileViewModel.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 08.06.2022.
//

import Foundation
protocol ProfileNavigation : AnyObject {
    func push()
    func pop()
}

class ProfileViewModel {
    
    weak var navigation : ProfileNavigation!
    
    init(nav : ProfileNavigation) {
        self.navigation = nav
    }
    
    func goToPhoto(){
        navigation.push()
    }
    
    func goHome(){
        navigation.pop()
    }
}
