//
//  Models.swift
//  myRealmProj
//
//  Created by kubmakk on 1/10/25.
//

import Foundation
import RealmSwift

class Quote: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var value: String
    @Persisted var categories = List<Category>()
    @Persisted var date: Date
    
    nonisolated override static func primaryKey() -> String? {
        return "id"
    }
}


class Category: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var name: String
    @Persisted(originProperty: "categories") var quotes: LinkingObjects<Quote>
    
    nonisolated override static func primaryKey() -> String? {
        return "name"
    }
}
