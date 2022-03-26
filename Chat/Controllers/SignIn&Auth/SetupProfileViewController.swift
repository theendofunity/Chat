//
//  SetupProfileViewController.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 14.03.2022.
//

import UIKit
import SwiftUI
import FirebaseAuth

class SetupProfileViewController: UIViewController {
    let setUpProfileLabel = UILabel(text: "Set up profile", font: .avenir26)
    
    let fullNameLabel = UILabel(text: "Full name")
    let aboutMeLabel = UILabel(text: "About me")
    let sexLabel = UILabel(text: "Sex")
    
    let fillImageView = AddPhotoView()
    
    let fullNameTextField = OneLineTextField(font: .avenir20)
    let aboutMeTextField = OneLineTextField(font: .avenir20)
    
    let sexSegmentedControl = UISegmentedControl(items: ["Male", "Female"])
    
    let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .buttonBlack, isShadow: false)
    
    let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        
        if let username = currentUser.displayName {
            fullNameTextField.text = username
        }
        
        goToChatsButton.addTarget(self, action: #selector(goToChats), for: .touchUpInside)
    }
    
    @objc func goToChats() {
        FirestoreService.shared.saveProfileWith(id: currentUser.uid,
                                                email: currentUser.email!,
                                                username: fullNameTextField.text,
                                                avatarImageString: "nil",
                                                description: aboutMeTextField.text,
                                                sex: sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)) { result in
            switch result {
            case .success(let user):
                self.showAlert(title: "Success", message: nil) {
                    let mainTabbar = MainTabBarViewController(currentUser: user)
                    mainTabbar.modalPresentationStyle = .fullScreen
                    self.present(mainTabbar, animated: true, completion: nil)
                }
            case .failure(let error):
                self.showError(error: error)
            }
        }
    }
}

extension SetupProfileViewController {
    private func setupConstraints() {
        let fullNameStack = UIStackView(arrangedSubviews: [
            fullNameLabel,
            fullNameTextField
        ],
                                        axis: .vertical,
                                        spacing: 0)
        let aboutMeStack = UIStackView(arrangedSubviews: [
            aboutMeLabel,
            aboutMeTextField
        ],
                                       axis: .vertical,
                                       spacing: 0)
        
        let sexStack = UIStackView(arrangedSubviews: [
            sexLabel,
            sexSegmentedControl
        ],
                                   axis: .vertical,
                                   spacing: 0)
        let stack = UIStackView(arrangedSubviews: [
            fullNameStack,
            aboutMeStack,
            sexStack,
            goToChatsButton
        ],
                                axis: .vertical,
                                spacing: 40)
        
        setUpProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        fillImageView.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(setUpProfileLabel)
        view.addSubview(fillImageView)
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            goToChatsButton.heightAnchor.constraint(equalToConstant: 60),
            
            setUpProfileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            setUpProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fillImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fillImageView.topAnchor.constraint(equalTo: setUpProfileLabel.bottomAnchor, constant: 40),
            
            stack.topAnchor.constraint(equalTo: fillImageView.bottomAnchor, constant: 40),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
        ])
    }
}
