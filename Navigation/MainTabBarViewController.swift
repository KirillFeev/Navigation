//
//  MainTabBarViewController.swift
//  Navigation
//
//  Created by Кирилл on 21.04.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    let feedVc = FeedViewController()
//    let profileVc = ProfileViewController()
    let profileVc = LogInViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupControllers()
    }

    private func setupControllers() {
        
        let feedNavController = UINavigationController(rootViewController: feedVc)
        feedVc.tabBarItem.title = "Лента"
        feedVc.tabBarItem.image = UIImage(systemName: "bolt")
        
        let profileNavController = UINavigationController(rootViewController: profileVc)
        profileVc.tabBarItem.title = "Профиль пользователя"
        profileVc.tabBarItem.image = UIImage(systemName: "face.smiling")
        profileVc.navigationItem.title = "Profile"
        profileNavController.navigationBar.isHidden = true
        
        viewControllers = [feedNavController, profileNavController]
    }
}
