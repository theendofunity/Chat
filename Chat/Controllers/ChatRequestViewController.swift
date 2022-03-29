//
//  ChatRequestViewController.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 19.03.2022.
//

import UIKit
import SwiftUI
import SDWebImage

class ChatRequestViewController: UIViewController {
    let containerView = UIView()
    let imageView = UIImageView(image: UIImage(named: "capibara"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Peter Capibara", font: .systemFont(ofSize: 20, weight: .light))
    let aboutLabel = UILabel(text: "You have the opportunity to start new chat", font: .systemFont(ofSize: 16, weight: .light))
    let acceptButton = UIButton(title: "Accept", titleColor: .white, backgroundColor: .black, font: .lao20, isShadow: false, cornerRadius: 10)
    let denyButton = UIButton(title: "Deny", titleColor: .buttonRed, backgroundColor: .mainWhite, font: .lao20, isShadow: false, cornerRadius: 10)
    
    weak var delegate: WaitingChatsNavigation?
    private var chat: Chat
    
    init(chat: Chat) {
        self.chat = chat
        self.nameLabel.text = chat.friendUsername
        self.aboutLabel.text = chat.lastMessageContent
        
        if let url = URL(string: chat.friendImageString) {
            imageView.sd_setImage(with: url)
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
        
        denyButton.addTarget(self, action: #selector(denyButtonTapped), for: .touchUpInside)
        acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        acceptButton.applyGradient(cornerRadius: 10)
    }
    
    @objc func denyButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.removeWaitingChat(chat: self.chat)
        }
    }
    
    @objc func acceptButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.moveToActive(chat: self.chat)
        }
    }
}

// MARK: - Setup constraints

extension ChatRequestViewController {
    func setupView() {
        view.backgroundColor = .mainWhite
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        
        aboutLabel.numberOfLines = 0
        containerView.backgroundColor = .mainWhite
        containerView.layer.cornerRadius = 30
        
        denyButton.layer.borderWidth = 1.2
        denyButton.layer.borderColor = UIColor.buttonRed.cgColor
        
    }
    
    func setupConstraints() {
        let buttonStack = UIStackView(arrangedSubviews: [acceptButton, denyButton], axis: .horizontal, spacing: 20)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.distribution = .fillEqually
        
        view.addSubview(imageView)
        view.addSubview(containerView)
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(aboutLabel)
        containerView.addSubview(buttonStack)
        
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
            
            buttonStack.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 24),
            buttonStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            buttonStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            buttonStack.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
