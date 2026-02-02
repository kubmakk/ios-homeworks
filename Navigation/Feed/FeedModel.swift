//
//  FeedModel.swift
//  Navigation
//
//  Created by kubmakk on 2/2/26.
//

import Foundation

class FeedModel {
    private let secretWord: String
    
    init(secretWord: String) {
        self.secretWord = secretWord
    }
    
    func check(word: String) {
        let isCorrect = word == self.secretWord
        NotificationCenter.default.post(name: .wordChecked, object: nil, userInfo: ["result": isCorrect])
    }
}

// MARK: - Extension
extension Notification.Name {
    static let wordChecked = Notification.Name("wordChecked")
}
