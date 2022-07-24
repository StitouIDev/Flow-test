//
//  UserListPage.swift
//  Flow test
//
//  Created by HAMZA on 24/7/2022.
//

import UIKit

class UserListPage: UIViewController {
    
    private var users = [User]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Users List"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        getUsers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    func getUsers() {
        ApiManager.shared.getUsers { [weak self] result in
            switch result {
            case .success(let User):
                self?.users = User
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension UserListPage: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = "My name \(user.first_name), \(user.last_name) , Mon email est : \(user.email) "
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
}
