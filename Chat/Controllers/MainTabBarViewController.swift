//
//  MainTabBarViewController.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 15.03.2022.
//

import UIKit
import SwiftUI

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupSearchBar()
    }
    
    func setupTabBar() {
        tabBar.tintColor = .tabbarTintColor
        let listViewController = ListViewController()
        let peopleViewController = PeopleViewController()
        
        let imageConfiguration = UIImage.SymbolConfiguration(weight: .medium)
        let conversationImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: imageConfiguration)
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: imageConfiguration)
        
        viewControllers = [
            createNavigationController(rootViewController: listViewController, title: "Conversations", image: conversationImage),
            createNavigationController(rootViewController: peopleViewController, title: "People", image: peopleImage)
        ]
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
