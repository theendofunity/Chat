//
//  UserCell.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 17.03.2022.
//

import UIKit

class UserCell: UICollectionViewCell {
    let userImageView = UIImageView()
    let usernameLabel = UILabel(text: "text", font: .lao20)
    let container = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
//        layer.borderWidth = 1
        layer.shadowColor = UIColor(red: 189, green: 189, blue: 189).cgColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 4)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.container.layer.cornerRadius = 4
        self.container.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(container)
        container.addSubview(userImageView)
        container.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            userImageView.topAnchor.constraint(equalTo: container.topAnchor),
            userImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            userImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            userImageView.heightAnchor.constraint(equalTo: container.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            usernameLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ])
    }
}

extension UserCell: SelfConfiguringCell {
    func configure<U>(with value: U) where U : Hashable {
        guard let user = value as? User else { return }
        usernameLabel.text = user.username
        userImageView.image = UIImage(named: user.avatarStringURL)
    }
    
    static var reuseId: String {
        return NSStringFromClass(UserCell.self)
    }
}
