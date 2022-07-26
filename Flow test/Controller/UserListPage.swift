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
        view.backgroundColor = .black
        title = "User List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(dismissSelf))
        
        fetchData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // fetch data
    private func fetchData() {
        CoreDataManager.DataManager.shared.fetchingUsers { result in
            switch result {
            case .success(let users):
                self.usersCore = users
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }

    
}

// MARK: Table View Conform Protocol


extension UserListPage: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersCore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDisplayCell.identifier, for: indexPath) as? UserDisplayCell  else {
            return UITableViewCell()
        }
        let user = usersCore[indexPath.row]
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
