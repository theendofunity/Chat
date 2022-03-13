//
//  SetupProfileViewController.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 14.03.2022.
//

import UIKit
import SwiftUI

class SetupProfileViewController: UIViewController {
    let fillImageView = AddPhotoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        
    }
}

extension SetupProfileViewController {
    private func setupConstraints() {
        fillImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(fillImageView)
        
        
        NSLayoutConstraint.activate([
            fillImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fillImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160)
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
