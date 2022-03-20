//
//  ViewController.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 09.03.2022.
//

import UIKit
import SwiftUI

class AuthViewController: UIViewController {
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Logo"), contentMode: .scaleAspectFit)
    
    var googleLabel = UILabel(text: "Get started with")
    var emailLabel = UILabel(text: "Or sign up with")
    var loginLabel = UILabel(text: "Already onboard?")
    
    var googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    var emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .buttonBlack, isShadow: false)
    var loginButton = UIButton(title: "Login", titleColor: .buttonRed, backgroundColor: .white, isShadow: true)
    
    let signUpViewController = SignUpViewController()
    let loginViewController = LoginViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    
}

//MARK: - Setup Constraints

extension AuthViewController {
    private func setupConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        googleButton.gooleButton()
        let googleView = ButtonFormView(label: googleLabel, button: googleButton)
        let emailView = ButtonFormView(label: emailLabel, button: emailButton)
        let loginView = ButtonFormView(label: loginLabel, button: loginButton)
        
        let stackView = UIStackView(arrangedSubviews: [googleView, emailView, loginView], axis: .vertical, spacing: 40)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
        
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 160),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

extension AuthViewController {
    @objc func googleButtonTapped() {
    }
    
    @objc func emailButtonTapped() {
        present(signUpViewController, animated: true, completion: nil)
    }
    
    @objc func loginButtonTapped() {
        present(loginViewController , animated: true, completion: nil)
    }
}

//MARK: - SwiftUI

struct AuthViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = AuthViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
