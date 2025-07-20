//
//  MainTabBarCoordinator.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 21.06.2025.
//

import UIKit

// MARK: - MainTabBarCoordinator
final class MainTabBarCoordinator: Coordinator {
    // MARK: - Properties
    var navigationController: UINavigationController
    private let categoryRepository: CategoryRepository
    private var frameRepository: FrameRepository
    private let factory: MainTabBarFactory
    private var childCoordinators: [Coordinator] = []
    
    // MARK: - Init
    init(navigationController: UINavigationController, factory: MainTabBarFactory, categoryRepository: CategoryRepository, frameRepository: FrameRepository) {
        self.navigationController = navigationController
        self.factory = factory
        self.categoryRepository = categoryRepository
        self.frameRepository = frameRepository
    }
    
    // MARK: - Methods
    func start() {
        let mainTabBarController = factory.makeMainTabBarController()
        self.navigationController.pushViewController(mainTabBarController, animated: true)
        
        self.childCoordinators = factory.makeChildCoordinators(categoryRepository: categoryRepository, frameRepository: frameRepository)
        self.childCoordinators.forEach { $0.start() }
        
        mainTabBarController.viewControllers = childCoordinators.map { $0.navigationController }
    }
}
