//
//  ActiveChatCell.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 16.03.2022.
//

import UIKit
import SwiftUI
import SDWebImage

class ActiveChatCell: UICollectionViewCell {
    let userImageView = UIImageView()
    let usernameLabel = UILabel(text: "Name", font: .lao20)
    let lastMessageLabel = UILabel(text: "Message", font: .lao18)
    let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: .systemPurple, endColor: .systemBlue)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints

extension ActiveChatCell {
    func setupConstraints() {
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .white
        layer.cornerRadius = 4
        layer.masksToBounds = true

        addSubview(userImageView)
        addSubview(usernameLabel)
        addSubview(lastMessageLabel)
        addSubview(gradientView)
        
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 78),
            userImageView.heightAnchor.constraint(equalToConstant: 78),
            
            usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            usernameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 16),
            usernameLabel.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16),
            
            lastMessageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            lastMessageLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 16),
            lastMessageLabel.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16),
            
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientView.centerYAnchor.constraint(equalTo: centerYAnchor),
            gradientView.widthAnchor.constraint(equalToConstant: 8),
            gradientView.heightAnchor.constraint(equalToConstant: 78),
        ])
    }
}

extension ActiveChatCell: SelfConfiguringCell {
    func configure<U>(with value: U) where U : Hashable {
        guard let chat = value as? Chat else { return }
        
        userImageView.sd_setImage(with: URL(string: chat.friendImageString))
        usernameLabel.text = chat.friendUsername
        lastMessageLabel.text = chat.lastMessageContent
    }
    
    static var reuseId: String {
        return NSStringFromClass(ActiveChatCell.self)
    }
}
