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
        tableView.register(UserDisplayCell.self, forCellReuseIdentifier: UserDisplayCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Users List"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDisplayCell.identifier, for: indexPath) as? UserDisplayCell  else {
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = users[indexPath.row]
        let vc = UserEditPage()
        vc.configure(with: user)
        navigationController?.pushViewController(vc, animated: true)
                
        }
}
