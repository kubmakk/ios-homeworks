//
//  FavoriteViewModel.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 15.11.2022.
//

import Foundation
protocol FavoriteNavigation : AnyObject {
    func push()
    func pop()
}

class FavoriteViewModel {
    
    weak var navigation : FavoriteNavigation!
    
    init(nav : FavoriteNavigation) {
        self.navigation = nav
    }
    
    func push(){
        navigation.push()
    }
    
    func pop(){
        navigation.pop()
    }
}
