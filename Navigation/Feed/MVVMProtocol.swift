//
//  information.swift
//  Navigation
//
//  Created by kubmakk on 23.03.2025.
//

import Foundation

struct UserModel {
    let fullName: String
    var status: String
    let avatarUrl: String?

    init(fullName: String, status: String, avatarUrl: String? = nil) {
        self.fullName = fullName
        self.status = status
        self.avatarUrl = avatarUrl
    }
}

protocol FeedProfile: AnyObject {
    var name: String { get }
    var statusUser: String { get set }
    
    var updatedIfNeed: ((String) -> Void)? { get set }
}
