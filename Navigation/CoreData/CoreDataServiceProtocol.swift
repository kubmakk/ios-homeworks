//
//  CoreDataServiceProtocol.swift
//  Navigation
//
//  Created by kubmakk on 2/2/26.
//

import Foundation
import StorageService
import CoreData

protocol CoreDataServiceProtocol {
    func saveFavorite(post: Post)
    func fetchFavorites() -> [FavoritePost]
    func removeFavorite(byId id: String)
    func removeFavorite(for post: Post)
    func isFavorite(post: Post) -> Bool
    func mapToPost(_ favorite: FavoritePost) -> Post
}
