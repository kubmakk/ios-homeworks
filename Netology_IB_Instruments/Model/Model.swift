//
//  Model.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 23.05.2022.
//

import Foundation

class Model {
    let password: String = "password"
    var check: Bool = true {
        didSet {
            NotificationCenter.default.post(name:  NSNotification.Name("myEvent"), object: nil)
        }
    }
    func check(word: String){
        if word.hash == password.hash {
            check = true
            print("green label \(word)")
        } else {
            check = false
            print("red label \(word)")
        }
    }
}

