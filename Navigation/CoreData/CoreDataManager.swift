//
//  CoreDataManager.swift
//  Navigation
//
//  Created by kubmakk on 2/10/25.
//

import Foundation
import CoreData
import StorageService

final class CoreDataManager: CoreDataServiceProtocol {
    static let shared = CoreDataManager()

    private init() {}

    // MARK: - Persistent Container

    lazy var persistentContainer: NSPersistentContainer = {
        let model = CoreDataManager.makeModel()
        let container = NSPersistentContainer(name: "FavoritesModel", managedObjectModel: model)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                assertionFailure("Unresolved CoreData error: \(error), \(error.userInfo)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    var viewContext: NSManagedObjectContext { persistentContainer.viewContext }

    // MARK: - Model

    static func makeModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()


        let favoriteEntity = NSEntityDescription()
        favoriteEntity.name = "FavoritePost"
        favoriteEntity.managedObjectClassName = "FavoritePost"


        let idAttr = NSAttributeDescription()
        idAttr.name = "id"
        idAttr.attributeType = .stringAttributeType
        idAttr.isOptional = false

        let authorAttr = NSAttributeDescription()
        authorAttr.name = "author"
        authorAttr.attributeType = .stringAttributeType
        authorAttr.isOptional = false

        let textAttr = NSAttributeDescription()
        textAttr.name = "text"
        textAttr.attributeType = .stringAttributeType
        textAttr.isOptional = false

        let imageNameAttr = NSAttributeDescription()
        imageNameAttr.name = "imageName"
        imageNameAttr.attributeType = .stringAttributeType
        imageNameAttr.isOptional = false

        let likesAttr = NSAttributeDescription()
        likesAttr.name = "likes"
        likesAttr.attributeType = .integer64AttributeType
        likesAttr.isOptional = false

        let viewsAttr = NSAttributeDescription()
        viewsAttr.name = "views"
        viewsAttr.attributeType = .integer64AttributeType
        viewsAttr.isOptional = false

        let createdAtAttr = NSAttributeDescription()
        createdAtAttr.name = "createdAt"
        createdAtAttr.attributeType = .dateAttributeType
        createdAtAttr.isOptional = false

        favoriteEntity.properties = [idAttr, authorAttr, textAttr, imageNameAttr, likesAttr, viewsAttr, createdAtAttr]
        favoriteEntity.uniquenessConstraints = [["id"]]

        model.entities = [favoriteEntity]
        return model
    }

    // MARK: - CRUD

    func saveContext() {
        let context = viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            assertionFailure("Failed saving context: \(error)")
        }
    }

    func makeId(for post: Post) -> String {
        return "\(post.author)|\(post.image)"
    }

    func isFavorite(post: Post) -> Bool {
        let id = makeId(for: post)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritePost")
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        do {
            let count = try viewContext.count(for: request)
            return count > 0
        } catch {
            return false
        }
    }

    func saveFavorite(post: Post) {
        let id = makeId(for: post)


        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritePost")
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        do {
            let count = try viewContext.count(for: request)
            if count > 0 { return }
        } catch {}

        guard let entity = NSEntityDescription.entity(forEntityName: "FavoritePost", in: viewContext) else { return }
        let favorite = FavoritePost(entity: entity, insertInto: viewContext)
        favorite.id = id
        favorite.author = post.author
        favorite.text = post.description
        favorite.imageName = post.image
        favorite.likes = Int64(post.likes)
        favorite.views = Int64(post.views)
        favorite.createdAt = Date()

        saveContext()
        notifyFavoritesChanged()
    }

    func fetchFavorites() -> [FavoritePost] {
        let request = NSFetchRequest<FavoritePost>(entityName: "FavoritePost")
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }

    func removeFavorite(byId id: String) {
        let request = NSFetchRequest<FavoritePost>(entityName: "FavoritePost")
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        do {
            if let obj = try viewContext.fetch(request).first {
                viewContext.delete(obj)
                saveContext()
                notifyFavoritesChanged()
            }
        } catch {

            print("### Ошибка при удалении из CoreData: \(error)")
        }
    }

    func removeFavorite(for post: Post) {
        let id = makeId(for: post)
        removeFavorite(byId: id)
    }

    func mapToPost(_ favorite: FavoritePost) -> Post {
        return Post(
            author: favorite.author,
            description: favorite.text,
            image: favorite.imageName,
            likes: Int(favorite.likes),
            views: Int(favorite.views)
        )
    }
}

extension CoreDataManager {
    private func notifyFavoritesChanged() {
        NotificationCenter.default.post(name: .favoritesDidChange, object: nil)
    }
}

extension Notification.Name {
    static let favoritesDidChange = Notification.Name("favoritesDidChange")
}



