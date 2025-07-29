//
//  FavoritesManager.swift
//  PostsAppTZ
//
//  Created by Faryk on 28.07.2025.
//

import CoreData
import UIKit

class FavoritesManager {

    static let shared = FavoritesManager()

    private let context: NSManagedObjectContext

    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }

    // 1. Save a favorite post
    func saveFavorite(post: Post) {
        let favorite = FavoritePost(context: context)
        favorite.userId = Int64(post.userId)
        favorite.id = Int64(post.id)
        favorite.title = post.title
        favorite.body = post.body

        do {
            try context.save()
        } catch {
            print("Error saving favorite: \(error)")
        }
    }

    // 2. Load all favorites
    func loadFavorites() -> [FavoritePost] {
        let request: NSFetchRequest<FavoritePost> = FavoritePost.fetchRequest()

        do {
            return try context.fetch(request)
        } catch {
            print("Error loading favorites: \(error)")
            return []
        }
    }

    // 3. Check if a post is already favorited
    func isPostFavorited(postId: Int) -> Bool {
        let request: NSFetchRequest<FavoritePost> = FavoritePost.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", postId)

        do {
            let matches = try context.fetch(request)
            return !matches.isEmpty
        } catch {
            print("Error checking favorite status: \(error)")
            return false
        }
    }

    // 4. Remove favorite (optional)
    func removeFavorite(postId: Int) {
        let request: NSFetchRequest<FavoritePost> = FavoritePost.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", postId)

        do {
            let matches = try context.fetch(request)
            for object in matches {
                context.delete(object)
            }
            try context.save()
        } catch {
            print("Error removing favorite: \(error)")
        }
    }
}

