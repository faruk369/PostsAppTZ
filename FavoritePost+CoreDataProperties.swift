//
//  FavoritePost+CoreDataProperties.swift
//  PostsAppTZ
//
//  Created by Faryk on 28.07.2025.
//
//

import Foundation
import CoreData


extension FavoritePost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritePost> {
        return NSFetchRequest<FavoritePost>(entityName: "FavoritePost")
    }

    @NSManaged public var userId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var body: String?

}

extension FavoritePost : Identifiable {

}
