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
