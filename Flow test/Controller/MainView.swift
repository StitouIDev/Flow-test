//
//  ViewController.swift
//  Flow test
//
//  Created by HAMZA on 24/7/2022.
//

import UIKit

class MainView: UIViewController {
    
    private var users = [User]()
    
    private var showPop: PopUp!
    
    private let UserListButton: UIButton = {
        let button = UIButton()
        button.setTitle("User List", for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.masksToBounds = true
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let popUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("PopUp", for: .normal)
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
        view.addSubview(popUpButton)
        
        UserListButton.addTarget(self, action: #selector(UserListButtonClicked), for: .touchUpInside)
        
        popUpButton.addTarget(self, action: #selector(popUpButtonClicked), for: .touchUpInside)
    }
    
    @objc private func popUpButtonClicked() {
        showPop = PopUp(frame: view.frame)
        showPop.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        showPop.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        view.addSubview(showPop)
    }
    
    @objc private func okButtonClicked() {
        print("Button OK Clicked")
        showPop.removeFromSuperview()
    }
    
    @objc private func cancelButtonClicked() {
        print("Button Cancel Clicked")
        showPop.removeFromSuperview()
    }
    
    @objc private func UserListButtonClicked() {
        
       // DataManager.shared.deleteAllArticles()
        
        ApiManager.shared.getUsers { [weak self] result in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    let rootVC = UserListPage()
                    if DataManager.shared.isEmpty() {
                    self?.apiToCoreData(users: users)
                    }
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
        
        popUpButton.frame = CGRect(x: view.frame.size.width/2 - 80,
                                      y: UserListButton.frame.origin.y + UserListButton.frame.size.height + 20,
                                      width: 160,
                                      height: 60)
    }
    
}

