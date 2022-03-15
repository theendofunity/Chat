//
//  SetupProfileViewController.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 14.03.2022.
//

import UIKit
import SwiftUI

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        
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
            setUpProfileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            setUpProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fillImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fillImageView.topAnchor.constraint(equalTo: setUpProfileLabel.bottomAnchor, constant: 40),
            
            stack.topAnchor.constraint(equalTo: fillImageView.bottomAnchor, constant: 40),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            goToChatsButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}

//MARK: - SwiftUI
struct SetupProfileViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = SetupProfileViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
