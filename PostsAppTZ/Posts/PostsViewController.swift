//
//  PostsViewController.swift
//  PostsAppTZ
//
//  Created by Faryk on 17.07.2025.
//

import UIKit
import Alamofire
import SDWebImage

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate {

    var tableView = UITableView()
    var viewModel = PostViewModel()

    // To track favorites for UI (optional caching)
    var favoritePostIds: Set<Int> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        setupTableViewConstraints(tableView)

        // Load favorites to track which posts are favorited
        loadFavoritePostIds()

        viewModel.fetchPosts { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func loadFavoritePostIds() {
        let favorites = FavoritesManager.shared.loadFavorites()
        favoritePostIds = Set(favorites.map { Int($0.id) })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? TableViewCell else {
            fatalError("Could not dequeue PostTableViewCell")
        }
        cell.setupConstraints(showFavoriteButton: true)
        let post = viewModel.post(at: indexPath.row)
        let isFavorited = favoritePostIds.contains(post.id)
        cell.configure(with: post, isFavorited: isFavorited)
        cell.delegate = self
        return cell
    }

    // MARK: - TableViewCellDelegate

    func didTapFavoriteButton(on cell: TableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }

        let post = viewModel.post(at: indexPath.row)

        if favoritePostIds.contains(post.id) {
            // Optionally: remove favorite
            FavoritesManager.shared.removeFavorite(postId: post.id)
            favoritePostIds.remove(post.id)
        } else {
            FavoritesManager.shared.saveFavorite(post: post)
            favoritePostIds.insert(post.id)
        }

        // Reload that row to update heart button state
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "PostCell")
    }
}
