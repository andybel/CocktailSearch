//
//  SceneDelegate.swift
//  CocktailSearch
//
//  Created by Andy Bell on 04.11.20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
    
        let navController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

