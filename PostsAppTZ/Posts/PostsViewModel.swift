//
//  PostsViewModel.swift
//  PostsAppTZ
//
//  Created by Faryk on 24.07.2025.


import Alamofire
import Foundation

class PostViewModel {
    var posts: [Post] = [] 

    func fetchPosts(completion: @escaping () -> Void) {
        let url = "https://jsonplaceholder.typicode.com/posts"

        AF.request(url)
            .validate()
            .responseDecodable(of: [Post].self) { response in
                switch response.result {
                case .success(let posts):
                    self.posts = posts
                case .failure(let error):
                    print("Failed to fetch posts:", error)
                    self.posts = []
                }
                completion()
            }
    }

    var count: Int {
        posts.count
    }

    func post(at index: Int) -> Post {
        posts[index]
    }

    func username(for post: Post) -> String {
        return "user\(post.userId)"
    }

    func profileImageUrl(for post: Post) -> URL? {
        return URL(string: "https://i.pravatar.cc/150?u=\(post.userId)")
    }
}
