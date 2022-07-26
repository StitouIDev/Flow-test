//
//  UserDisplayCell.swift
//  Flow test
//
//  Created by HAMZA on 24/7/2022.
//

import UIKit
import SDWebImage

// MARK: Display users List

class UserDisplayCell: UITableViewCell {

    static let identifier = "UserDisplayCell"
    
    private let image: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let email: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(image)
        contentView.addSubview(name)
        contentView.addSubview(email)
        
        applyConstraints()
        
    }
    
    // Constarints Apply 
    private func applyConstraints() {
        
        let imageConstraints = [
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            image.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let nameConstraints = [
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
        ]
        
        let emailConstraints = [
            email.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            email.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(nameConstraints)
        NSLayoutConstraint.activate(emailConstraints)
    }
    
    public func configure(with model: UserItem) {
    
        guard let url = URL(string: model.avatar ?? "" ) else {
            return
        }
        image.sd_setImage(with: url, completed: nil)
        name.text = "Name:   \(model.first_name!) \(model.last_name!)"
        email.text = "Email:   \(model.email!)"
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
