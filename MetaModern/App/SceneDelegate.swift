//
//  SceneDelegate.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 21.06.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        let appFactory = AppFactory()
        let categoryRepository = CategoryRepositoryImp()
        
        appCoordinator = AppCoordinator(navigationController: navigationController, categoryRepository: categoryRepository, factory: appFactory, window: window)
        appCoordinator?.start()
    }

}

