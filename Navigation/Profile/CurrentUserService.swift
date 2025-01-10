//
//  CurrentUserService.swift
//  Navigation
//
//  Created by kubmakk on 07.01.2025.
//

class CurrentUserService: UserService{
    private var currentUser: User?
    
    init(user: User){
        self.currentUser = user
    }
    
    func getUser(by login: String) -> User? {
        return currentUser?.login == login ? currentUser : nil
    }
}
