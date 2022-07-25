//
//  UserEditPage.swift
//  Flow test
//
//  Created by HAMZA on 25/7/2022.
//

import UIKit

class UserEditPage: UIViewController {
    
    private var testTable: [UserItem] = [UserItem]()
    public var user: UserItem?
    public var model: User?
    
    private let firstName: UITextField = {
            let field = UITextField()
            field.layer.masksToBounds = true
            field.layer.cornerRadius = 8.0
            field.backgroundColor = .systemPink
            field.layer.borderWidth = 1.0
            field.leftViewMode = .always
            field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        return field
    }()
    
    private let lastName: UITextField = {
        let field = UITextField()
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8.0
        field.backgroundColor = .systemPink
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.layer.borderWidth = 1.0
        return field
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        addSubviews()
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    }
    
    @objc private func saveButtonClicked() {
        guard let firstName = firstName.text, let lastName = lastName.text, let user = user else { return }
        DataManager.shared.editUser(with: user, lastName: lastName, firstName: firstName) { result in
            switch result {
            case .success(()):
                print("Edit")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let rootVC = UserListPage()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        
    }
    
    @objc private func cancelButtonClicked() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }

    
    private func deleteUser(model: UserItem) {
        DataManager.shared.deleteUser(with: model) { result in
            switch result {
            case .success():
                print("Deleted from Database")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveUser(model: User) {
        DataManager.shared.saveData(with: model) { result in
            switch result {
            case .success():
                print("Saved")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func configure(with model: UserItem) {
        firstName.text = model.first_name
        lastName.text = model.last_name
    }
    
    private func addSubviews() {
        view.addSubview(firstName)
        view.addSubview(lastName)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        firstName.frame = CGRect(
            x: 25,
            y: 140,
            width: view.frame.size.width - 50,
            height: 52)
        
        lastName.frame = CGRect(
            x: 25,
            y: firstName.frame.origin.y + firstName.frame.size.height + 20,
            width: view.frame.size.width - 50,
            height: 52)
        
        saveButton.frame = CGRect(
            x: 25,
            y: lastName.frame.origin.y + lastName.frame.size.height + 20,
            width: view.frame.size.width - 50,
            height: 52)
        
        cancelButton.frame = CGRect(
            x: 25,
            y: saveButton.frame.origin.y + saveButton.frame.size.height + 20,
            width: view.frame.size.width - 50,
            height: 52)
    }
}
