//
//  PostsViewController.swift
//  PostsAppTZ
//
//  Created by Faryk on 17.07.2025.
//

import UIKit
import Alamofire
import SDWebImage

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    var viewModel = PostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureTableView()
        setupTableViewConstraints()
        viewModel.fetchPosts { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func ConfigureTableView(){
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "PostCell") 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? TableViewCell else {
            fatalError("Could not dequeue TableViewCell")
        }
        
        let post = viewModel.post(at: indexPath.row)
        cell.configure(with: post)
        return cell
    }
}
