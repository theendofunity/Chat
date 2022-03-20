//
//  SignUpViewController.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 09.03.2022.
//

import UIKit
import SwiftUI

class SignUpViewController: UIViewController {

    let welcomeLabel = UILabel(text: "Good to see you!", font: .avenir26)
    
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let confirmPasswordLabel = UILabel(text: "ConfirmPassword")
    let alreadyOnboardLabel = UILabel(text: "Already onboard?")

    let signUpButton = UIButton(title: "Sign up", titleColor: .white, backgroundColor: .buttonBlack, isShadow: false)
    var loginButton: UIButton {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.buttonRed, for: .normal)
        button.titleLabel?.font = .avenir20
        return button
    }
    
    let emailTextField = OneLineTextField(font: .avenir20)
    let passwordTextField = OneLineTextField(font: .avenir20)
    let confirmPasswordTextField = OneLineTextField(font: .avenir20)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupConstraints()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

extension SignUpViewController {
    @objc func signUpButtonTapped() {
        AuthService.shared.register(email: emailTextField.text,
                                    password: passwordTextField.text,
                                    confirmPassword: confirmPasswordTextField.text) { result in
            switch result {
                
            case .success(_):
                self.showAlert(title: "Success!", message: "User successfully registered!")
            case .failure(let error):
                self.showError(error: error)
            }
        }
    }
    
    @objc func loginButtonTapped() {
        
    }
}

//MARK: - Constraints

extension SignUpViewController {
    private func setupConstraints() {
        let emailStack = UIStackView(arrangedSubviews: [
            emailLabel,
            emailTextField
        ],
                                     axis: .vertical,
                                     spacing: 0)
        let passwordStack = UIStackView(arrangedSubviews: [
            passwordLabel,
            passwordTextField
        ],
                                        axis: .vertical,
                                        spacing: 0)
        let confirmPasswordStack = UIStackView(arrangedSubviews: [
            confirmPasswordLabel,
            confirmPasswordTextField
        ],
                                               axis: .vertical,
                                               spacing: 0)
        
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let stack = UIStackView(arrangedSubviews: [
            emailStack,
            passwordStack,
            confirmPasswordStack,
            signUpButton
        ],
                                axis: .vertical,
                                spacing: 40)
        let bottomStack = UIStackView(arrangedSubviews: [
            alreadyOnboardLabel,
            loginButton
        ],
                                      axis: .horizontal,
                                      spacing: 10)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(stack)
        view.addSubview(bottomStack)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 100),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStack.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20),
            bottomStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])
    }
}

//MARK: - SwiftUI
struct SignUpViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = SignUpViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
