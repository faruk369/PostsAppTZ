//
//  TableViewCell.swift
//  PostsAppTZ
//
//  Created by Faryk on 27.07.2025.
//

import UIKit

class TableViewCell: UITableViewCell {

    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let postTextLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints() 
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 25

        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        postTextLabel.font = UIFont.systemFont(ofSize: 14)
        postTextLabel.numberOfLines = 0

        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(postTextLabel)
    }

    func configure(with post: Post) {
        usernameLabel.text = "user\(post.userId)"
        postTextLabel.text = post.title

        if let url = URL(string: "https://i.pravatar.cc/150?u=\(post.userId)") {
            profileImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.circle"))
        }
    }

}
