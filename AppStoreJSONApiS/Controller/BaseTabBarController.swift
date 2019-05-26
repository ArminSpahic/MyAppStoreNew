//
//  BaseTabBarController.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 05/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        
    }
    
    private func setupViewControllers() {
        viewControllers = [
            createNavController(viewController: TodayCollectionController(), title: "Today", imageName: "today_icon"),
            createNavController(viewController: AppsController(), title: "Apps", imageName: "apps"),
            createNavController(viewController: AppsSearchController(), title: "Search", imageName: "search"),
            createNavController(viewController: MusicCollectionViewController(), title: "Music", imageName: "music"),
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        
        return navController
        
    }
    
}
