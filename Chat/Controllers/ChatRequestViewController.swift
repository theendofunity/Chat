//
//  ChatRequestViewController.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 19.03.2022.
//

import UIKit
import SwiftUI

class ChatRequestViewController: UIViewController {
    let containerView = UIView()
    let imageView = UIImageView(image: UIImage(named: "capibara"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Peter Capibara", font: .systemFont(ofSize: 20, weight: .light))
    let aboutLabel = UILabel(text: "You have the opportunity to start new chat", font: .systemFont(ofSize: 16, weight: .light))
    let acceptButton = UIButton(title: "Accept", titleColor: .white, backgroundColor: .black, font: .lao20, isShadow: false, cornerRadius: 10)
    let denyButton = UIButton(title: "Deny", titleColor: .buttonRed, backgroundColor: .mainWhite, font: .lao20, isShadow: false, cornerRadius: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        acceptButton.applyGradient(cornerRadius: 10)
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

//MARK: - SwiftUI
struct ChatRequestViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = ChatRequestViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
