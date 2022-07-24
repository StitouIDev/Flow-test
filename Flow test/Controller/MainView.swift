//
//  ViewController.swift
//  Flow test
//
//  Created by HAMZA on 24/7/2022.
//

import UIKit

class MainView: UIViewController {
    
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
        let vc = UserListPage()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    


    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        UserListButton.frame = CGRect(x: view.frame.size.width/2 - 60,
                                      y: view.frame.size.height/2 - 20,
                                      width: 120,
                                      height: 40)
    }

}

