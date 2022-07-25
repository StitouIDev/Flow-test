//
//  ViewController.swift
//  Flow test
//
//  Created by HAMZA on 24/7/2022.
//

import UIKit

class MainView: UIViewController {
    
    private var users = [User]()
    
    private let UserListButton: UIButton = {
        let button = UIButton()
        button.setTitle("UserList", for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.masksToBounds = true
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGreen
        view.addSubview(UserListButton)
        
        
        UserListButton.addTarget(self, action: #selector(UserListButtonClicked), for: .touchUpInside)
    }
    
    @objc private func UserListButtonClicked() {
        
        DataManager.shared.deleteAllArticles()
        
        ApiManager.shared.getUsers { [weak self] result in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    let rootVC = UserListPage()
                    self?.apiToCoreData(users: users)
                    let navVC = UINavigationController(rootViewController: rootVC)
                    navVC.modalPresentationStyle = .fullScreen
                    
                    self?.present(navVC, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func saveUser(model: User) {
        DataManager.shared.saveData(with: model) { result in
            switch result {
            case .success(()):
                break
          //      NotificationCenter.default.post(name: NSNotification.Name("saved"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func apiToCoreData(users: [User]) {
        users.forEach { user in
            saveUser(model: user)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        UserListButton.frame = CGRect(x: view.frame.size.width/2 - 80,
                                      y: view.frame.size.height/2 - 30,
                                      width: 160,
                                      height: 60)
    }
    
}

