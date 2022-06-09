//
//  FeedViewModel.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 08.06.2022.
//

import Foundation

protocol FeedNavigation : AnyObject {
    func push()
    func pop()
}

class FeedViewModel {
    
    weak var navigation : FeedNavigation!
    
    init(nav : FeedNavigation) {
        self.navigation = nav
    }
    
    func goToPost(){
        navigation.push()
    }
    
    func goHome(){
        navigation.pop()
    }
}
