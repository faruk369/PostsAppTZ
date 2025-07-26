//
//  PostsModel.swift
//  PostsAppTZ
//
//  Created by Faryk on 24.07.2025.
//

import Foundation

struct Post {
    var username: String
    var profileImageName: String
    var text: String
}

let posts: [Post] = [
    Post(username: "elonmusk", profileImageName: "https://futureoflife.org/wp-content/uploads/2020/08/elon_musk_royal_society.jpg", text: "Starship launch successful 🚀"),
    Post(username: "nasa", profileImageName: "https://cdn.mos.cms.futurecdn.net/wqkwy8CNJGgWVp9nZBSqXk.jpg", text: "Earth is the only home we have. Let’s protect it."),
    Post(username: "swiftdev", profileImageName: "https://cdn4.iconfinder.com/data/icons/logos-3/504/Swift-2-512.png", text: "Async/await is a game changer in Swift.")
    
    ]
