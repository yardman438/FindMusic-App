//
//  SceneDelegate.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
//        let navigationController = UINavigationController(rootViewController: LoginScreenViewController())
//        let navigationController = UINavigationController(rootViewController: SearchViewController())

        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .dark
    }
}
