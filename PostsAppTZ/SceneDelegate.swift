//
//  SceneDelegate.swift
//  PostsAppTZ
//
//  Created by Faryk on 11.07.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        // Three tabs with nav controllers
        let postsVC = UINavigationController(rootViewController: PostsViewController())
        postsVC.tabBarItem = UITabBarItem(title: "Posts",
                                          image: UIImage(systemName: "doc.text"),
                                          tag: 0)

        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites",
                                              image: UIImage(systemName: "heart"),
                                              tag: 1)

        let settingsVC = UINavigationController(rootViewController: SettingsViewController())
        settingsVC.tabBarItem = UITabBarItem(title: "Settings",
                                             image: UIImage(systemName: "gear"),
                                             tag: 2)

        // Create tab bar controller and assign view controllers
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [postsVC, favoritesVC, settingsVC]

       
        
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }
}
