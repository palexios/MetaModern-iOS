//
//  CatalogCoordinator.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 22.06.2025.
//

import UIKit

// MARK: - CatalogCoordinator
final class CatalogCoordinator: Coordinator {
    // MARK: - Properties
    var navigationController: UINavigationController
    
    private let categoryRepository: CategoryRepository
    private let frameRepository: FrameRepository
    private let factory: CatalogFactory
    
    // MARK: - Init
    init(navigationController: UINavigationController, factory: CatalogFactory, categoryRepository: CategoryRepository, frameRepository: FrameRepository) {
        self.navigationController = navigationController
        self.factory = factory
        self.categoryRepository = categoryRepository
        self.frameRepository = frameRepository
    }
    
    // MARK: - Methods
    func start() {
        let vc = factory.makeCatalogViewController(categoryRepository: categoryRepository, frameRepository: frameRepository)
        let tabBarItem = factory.makeCatalogItemTabBar()
        vc.tabBarItem = tabBarItem
        
        self.navigationController.pushViewController(vc, animated: false)
    }
}
