//
//  TableViewCell.swift
//  PostsAppTZ
//
//  Created by Faryk on 27.07.2025.
//

import UIKit

class TableViewCell: UITableViewCell {

    weak var delegate: TableViewCellDelegate?
    
    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let postTextLabel = UILabel()
    let favoriteButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(profileImageView)
                contentView.addSubview(usernameLabel)
                contentView.addSubview(postTextLabel)
                contentView.addSubview(favoriteButton)
        
        setupViews()
        setupConstraints() 
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
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

    }

    func configure(with post: Post) {
        usernameLabel.text = "user\(post.userId)"
        postTextLabel.text = post.title

        if let url = URL(string: "https://i.pravatar.cc/150?u=\(post.userId)") {
            profileImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.circle"))
        }
    }
    private func setupFavoritebutton(){
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                favoriteButton.tintColor = .systemRed
                favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        contentView.addSubview(favoriteButton)
    }
    
    @objc private func favoriteButtonTapped() {
           delegate?.didTapFavoriteButton(on: self)
       }

       func configure(with post: Post, isFavorited: Bool = false) {
           usernameLabel.text = "user\(post.userId)"
           postTextLabel.text = post.title

           if let url = URL(string: "https://i.pravatar.cc/150?u=\(post.userId)") {
               profileImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.circle"))
           }

           // Update heart button appearance depending on favorite state
           let heartImageName = isFavorited ? "heart.fill" : "heart"
           favoriteButton.setImage(UIImage(systemName: heartImageName), for: .normal)
       }
}

protocol TableViewCellDelegate: AnyObject {
    func didTapFavoriteButton(on cell: TableViewCell)
}
