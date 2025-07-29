//
//  Contraints.swift
//  PostsAppTZ
//
//  Created by Faryk on 26.07.2025.
//

import UIKit

// MARK: - UIViewController Extension for TableView Constraints
extension UIViewController {
    /// Sets tableView constraints to fill the entire view.
    func setupTableViewConstraints(_ tableView: UITableView) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - TableViewCell Extension for Cell Layout Constraints
extension TableViewCell {
    
    /// Sets up the layout constraints for the cell UI components.
    /// - Parameter showFavoriteButton: Pass `true` to show the favorite (heart) button, `false` to hide it.
    public func setupConstraints(showFavoriteButton: Bool = true) {
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        postTextLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Deactivate all existing constraints on contentView to avoid conflicts (optional safety)
        NSLayoutConstraint.deactivate(contentView.constraints)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            usernameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: showFavoriteButton ? -60:-60),
            
            postTextLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            postTextLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            postTextLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: showFavoriteButton ? -60:-60),
            postTextLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
        
        if showFavoriteButton {
            NSLayoutConstraint.activate([
                favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                favoriteButton.widthAnchor.constraint(equalToConstant: 30),
                favoriteButton.heightAnchor.constraint(equalToConstant: 30)
            ])
            favoriteButton.isHidden = false
        } else {
            favoriteButton.isHidden = true
        }
    }
}



