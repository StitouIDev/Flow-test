//
//  UserListPage.swift
//  Flow test
//
//  Created by HAMZA on 24/7/2022.
//

import UIKit

class UserListPage: UIViewController {
    
    public var users = [User]()
    private var usersCore = [UserItem]()
    
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
        
        fetchData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    private func fetchData() {
        DataManager.shared.fetchingUsers { result in
            switch result {
            case .success(let users):
                self.usersCore = users
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func saveUser(indexPath: IndexPath) {
        DataManager.shared.saveData(with: users[indexPath.row]) { result in
            switch result {
            case .success(()):
                NotificationCenter.default.post(name: NSNotification.Name("saved"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension UserListPage: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersCore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDisplayCell.identifier, for: indexPath) as? UserDisplayCell  else {
            return UITableViewCell()
        }
        let user = usersCore[indexPath.row]
      //  self.saveUser(indexPath: indexPath)
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
        let user = usersCore[indexPath.row]
        let vc = UserEditPage()
        vc.configure(with: user)
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
                
        }
}
