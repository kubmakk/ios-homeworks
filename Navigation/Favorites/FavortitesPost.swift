//
//  FavortitesPost.swift
//  Navigation
//
//  Created by kubmakk on 2/10/25.
//

import Foundation
import CoreData

@objc(FavoritePost)
public class FavoritePost: NSManagedObject {
    @NSManaged public var id: String
    @NSManaged public var author: String
    @NSManaged public var text: String
    @NSManaged public var imageName: String
    @NSManaged public var likes: Int64
    @NSManaged public var views: Int64
    @NSManaged public var createdAt: Date
}



