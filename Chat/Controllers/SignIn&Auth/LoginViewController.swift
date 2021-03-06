//
//  LoginViewController.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 14.03.2022.
//

import UIKit
import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

class LoginViewController: UIViewController {
    let welcomeLabel = UILabel(text: "Welcome back", font: .avenir26)
    
    let loginWithLabel = UILabel(text: "Login with")
    let orLabel = UILabel(text: "or")
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let needAnAccountLabel = UILabel(text: "Need an account")
    
    var googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    
    let emailTextField = OneLineTextField(font: .avenir20)
    let passwordTextField = OneLineTextField(font: .avenir20)
    let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .buttonBlack, isShadow: false)
    var signUoButton: UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.buttonRed, for: .normal)
        button.titleLabel?.font = .avenir20
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }
    
    weak var delegate: AuthNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        googleButton.gooleButton()
        setupConstraints()
        
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

extension LoginViewController {
    @objc func loginButtonTapped() {
        AuthService.shared.login(email: emailTextField.text, password: passwordTextField.text) { result in
            switch result {
            case .success(let user):
                self.showAlert(title: "Success!", message: "User successfully sign in!") {
                    FirestoreService.shared.getUserData(user: user) { result in
                        switch result {
                        case .success(let mUser):
                            self.openMain(user: mUser)
                        case .failure(_):
                            self.openSetupProfile(user: user)
                        }
                    }
                }
            case .failure(let error):
                self.showError(error: error)
            }
        }
    }
    
    func openMain(user: MUser) {
        let mainTabbar = MainTabBarViewController(currentUser: user)
        mainTabbar.modalPresentationStyle = .fullScreen
        self.present(mainTabbar, animated: true, completion: nil)
    }
    
    func openSetupProfile(user: User) {
        self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
    }
    
    @objc func googleButtonTapped() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            AuthService.shared.googleLogin(user: user, error: error) { result  in
                switch result {
                case .success(let user):
                    FirestoreService.shared.getUserData(user: user) { result in
                        switch result {
                        case .success(let mUSer):
                            let tabbar = MainTabBarViewController(currentUser: mUSer)
                            tabbar.modalPresentationStyle = .fullScreen
                            self.present(tabbar, animated: true)
                        case .failure(_):
                            self.showAlert(title: "Success", message: "Register completed") {
                                self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                            }
                        }
                    }
                case .failure(let error):
                    self.showError(error: error)
                }
            }
        }
    }
    
    @objc func signUpButtonTapped() {
        print(#function)
        
        dismiss(animated: true) {
            self.delegate?.openSignUp()
        }
    }
}

extension LoginViewController {
    private func setupConstraints() {
        let loginWithView = ButtonFormView(label: loginWithLabel, button: googleButton)
        let emailStack = UIStackView(arrangedSubviews: [
            emailLabel,
            emailTextField],
                                     axis: .vertical,
                                     spacing: 0)
        let passwordStack = UIStackView(arrangedSubviews: [
            passwordLabel,
            passwordTextField],
                                        axis: .vertical,
                                        spacing: 0)
        
        let bottomStack = UIStackView(arrangedSubviews: [
            needAnAccountLabel,
            signUoButton],
                                      axis: .horizontal,
                                      spacing: 10)
        
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let mainStack = UIStackView(arrangedSubviews: [
            loginWithView,
            orLabel,
            emailStack,
            passwordStack,
            loginButton
        ],
                                    axis: .vertical,
                                    spacing: 40)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(mainStack)
        view.addSubview(bottomStack)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            
            mainStack.topAnchor.constraint(equalTo: welcomeLabel.topAnchor, constant: 100),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            bottomStack.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 20),
            bottomStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])
    }
}

//MARK: - SwiftUI
struct LoginViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = LoginViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
