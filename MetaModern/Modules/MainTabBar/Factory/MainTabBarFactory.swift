//
//  MainTabBarFactory.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 21.06.2025.
//

import UIKit

// MARK: - MainTabBarFactory
struct MainTabBarFactory {
    func makeMainTabBarController() -> UITabBarController {
        MainTabBarController()
    }
    
    func makeChildCoordinators(categoryRepository: CategoryRepository, frameRepository: FrameRepository) -> [Coordinator] {
        [makeCatalogCoordinator(categoryRepository: categoryRepository, frameRepository: frameRepository)]
    }
    
    private func makeCatalogCoordinator(categoryRepository: CategoryRepository, frameRepository: FrameRepository) -> Coordinator {
        let navigation = UINavigationController()
        navigation.isNavigationBarHidden = true
        let factory = CatalogFactoryImp()
        
        return CatalogCoordinator(navigationController: navigation, factory: factory, categoryRepository: categoryRepository, frameRepository: frameRepository)
    }
}
