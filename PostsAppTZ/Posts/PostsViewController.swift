//
//  PostsViewController.swift
//  PostsAppTZ
//
//  Created by Faryk on 17.07.2025.
//

import UIKit

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    let posts = ["Starship launch successful 🚀", "Earth is the only home we have. Let’s protect it.", "Async/await is a game changer in Swift."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureTableView()
        setupTableViewConstraints()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row]
        return cell
    }
    
    func ConfigureTableView(){
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.rowHeight  = 100
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    

}
