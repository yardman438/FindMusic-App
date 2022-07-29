//
//  MainTabBarController.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 29.07.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchVC = generateViewController(rootViewController: SearchViewController(), image: UIImage(named: "search")!, title: "Search")
        let libraryVC = generateViewController(rootViewController: LibraryViewController(), image: UIImage(named: "library")!, title: "Library")
        
        
        tabBar.tintColor = UIColor(named: "lightGreen")
        viewControllers = [searchVC, libraryVC]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
}
