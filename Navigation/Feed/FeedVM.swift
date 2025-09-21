//
//  FeedViewModel.swift
//  Navigation
//
//  Created by kubmakk on 23.03.2025.
//

import UIKit

final class FeedVM: FeedProfile {
    
    var name: String {
        return user.fullName
    }
    
    var statusUser: String
    
    var updatedIfNeed: ((String) -> Void)?
    
    private var user: UserModel
    
    init(user: UserModel, initialStatus: String) {
        self.user = user
        self.statusUser = initialStatus
    }
    
    func updateStatus(newStatus: String) {
        user.status = newStatus
        statusUser = newStatus
        updatedIfNeed?(newStatus)
    }
}
