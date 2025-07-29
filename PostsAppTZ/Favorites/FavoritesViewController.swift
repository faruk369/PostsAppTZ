//
//  FavoritesViewController.swift
//  PostsAppTZ
//
//  Created by Faryk on 17.07.2025.
//

import UIKit
import CoreData
import SDWebImage

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    var favoritePosts: [FavoritePost] = [] // Data from Core Data

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Favorites"

        setupTableView()
        setupTableViewConstraints(tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites() // Load every time tab appears
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "PostCell")
    }

    // MARK: - Table View Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? TableViewCell else {
            fatalError("Failed to dequeue PostCell")
        }

        let favorite = favoritePosts[indexPath.row]

        cell.usernameLabel.text = "User \(favorite.userId)"
        cell.postTextLabel.text = favorite.body
        cell.profileImageView.sd_setImage(
            with: URL(string: "https://i.pravatar.cc/150?u=\(favorite.userId)"),
            placeholderImage: UIImage(systemName: "person.circle")
        )
        
        // Hide favorite button on favorites tab
        cell.setupConstraints(showFavoriteButton: false)

        return cell  // <--- Must return the cell here!
    }
    
    // MARK: - Deleting favorited posts
    func deleteFavorite(_ favorite: FavoritePost) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        context.delete(favorite)
        do {
            try context.save()
            }catch{
                print("Failed to delete favorite: \(error)")
            }
        }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            let favoriteToDelete = favoritePosts[indexPath.row]
            deleteFavorite(favoriteToDelete)
            favoritePosts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    

    // MARK: - Core Data

    func loadFavorites() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<FavoritePost> = FavoritePost.fetchRequest()

        do {
            favoritePosts = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print("Failed to fetch favorite posts: \(error)")
        }
    }
}

