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
    
    func makeChildCoordinators(categoryRepository: CategoryRepository) -> [Coordinator] {
        [makeCatalogCoordinator(categoryRepository: categoryRepository)]
    }
    
    private func makeCatalogCoordinator(categoryRepository: CategoryRepository) -> Coordinator {
        let navigation = UINavigationController()
        navigation.isNavigationBarHidden = true
        let factory = CatalogFactoryImp()
        
        return CatalogCoordinator(navigationController: navigation, factory: factory, categoryRepository: categoryRepository)
    }
}
