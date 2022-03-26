//
//  MainTabBarViewController.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 15.03.2022.
//

import UIKit
import SwiftUI

class MainTabBarViewController: UITabBarController {
    private let currentUser: MUser
    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabBar()
    }
    
    func setupTabBar() {
        tabBar.tintColor = .tabbarTintColor
        let listViewController = ListViewController(currentUser: currentUser)
        let peopleViewController = PeopleViewController(currentUser: currentUser)
        
        let imageConfiguration = UIImage.SymbolConfiguration(weight: .medium)
        let conversationImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: imageConfiguration)
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: imageConfiguration)
        
        viewControllers = [
            createNavigationController(rootViewController: listViewController, title: "Conversations", image: conversationImage),
            createNavigationController(rootViewController: peopleViewController, title: "People", image: peopleImage)
        ]
        selectedIndex = 1
    }
    
    func setupSearchBar() {
        navigationController?.navigationBar.backgroundColor = .mainWhite
    }
    
    func createNavigationController(rootViewController: UIViewController, title: String, image: UIImage?)  -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.title = title
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
}
