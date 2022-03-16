//
//  ActiveChatCell.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 16.03.2022.
//

import UIKit
import SwiftUI

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
    static var reuseId: String {
        return NSStringFromClass(ActiveChatCell.self)
    }
    
    func configure(with value: Chat) {
        userImageView.image = UIImage(named: value.userImageString)
        usernameLabel.text = value.username
        lastMessageLabel.text = value.lastMessage
    }
}



//MARK: - SwiftUI
struct ActiveChatProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarVC = MainTabBarViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ActiveChatProvider.ContainerView>) -> MainTabBarViewController  {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: ActiveChatProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ActiveChatProvider.ContainerView>) {
            
        }
    }
}
