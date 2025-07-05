//
//  AppFactory.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 21.06.2025.
//

import UIKit

// MARK: - AppFactory
struct AppFactory {
    func makeOnboardingCoordinator(navigationController: UINavigationController) -> Coordinator {
        let factory = OnboardingFactory()
        let coordinator = OnboardingCoordinator(navigationController: navigationController, factory: factory)
        
        return coordinator
    }
    
    func makeMainTabBarCoordinator(navigationController: UINavigationController) -> Coordinator {
        let factory = MainTabBarFactory()
        let coordinator = MainTabBarCoordinator(navigationController: navigationController, factory: factory)
        
        return coordinator
    }
}
