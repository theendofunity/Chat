//
//  ProfileViewController.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 18.03.2022.
//

import UIKit
import SwiftUI
import SDWebImage

class ProfileViewController: UIViewController {
    let containerView = UIView()
    let imageView = UIImageView(image: UIImage(named: "capibara"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Peter Capibara", font: .systemFont(ofSize: 20, weight: .light))
    let aboutLabel = UILabel(text: "How are you?", font: .systemFont(ofSize: 16, weight: .light))
    let textField = InsertableTextField()
    
    private let user: MUser
    
    init(user: MUser) {
        self.user = user
        self.nameLabel.text = user.username
        self.aboutLabel.text = user.description
        
        if let imageUrl = URL(string: user.avatarStringURL) {
            self.imageView.sd_setImage(with: imageUrl)
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
}

// MARK: - Setup constraints

extension ProfileViewController {
    func setupView() {
        view.backgroundColor = .mainWhite

        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        aboutLabel.numberOfLines = 0
        containerView.backgroundColor = .mainWhite
        containerView.layer.cornerRadius = 30
        
        if let button = textField.rightView as? UIButton {
            button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        }
    }
    
    @objc func sendMessage() {
        guard let message = textField.text, !message.isEmpty else { return }
        
        self.dismiss(animated: true) {
            FirestoreService.shared.createWaitingChat(message: message, receiver: self.user) { result in
                print(result)
                switch result {
                case .success():
                    UIApplication.getTopViewController()?.showAlert(title: "Success", message: "You're message was sended")
                case .failure(let error):
                    UIApplication.getTopViewController()?.showError(error: error)
                }
            }
        }
    }
    
    func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(containerView)

        containerView.addSubview(nameLabel)
        containerView.addSubview(aboutLabel)
        containerView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 206),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            aboutLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8 ),
            aboutLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            aboutLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            textField.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 8 ),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            textField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
