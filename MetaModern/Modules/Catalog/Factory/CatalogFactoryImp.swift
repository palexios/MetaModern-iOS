//
//  CatalogFactoryImp.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 22.06.2025.
//

import UIKit

// MARK: - CatalogFactoryImp
struct CatalogFactoryImp: CatalogFactory {
    func makeCatalogViewController(categoryRepository: CategoryRepository) -> UIViewController {
        let vm = CatalogViewModel(categoryRepository: categoryRepository)
        
        return CatalogViewController(viewModel: vm)
    }
    
    func makeCatalogItemTabBar() -> UITabBarItem {
        makeItemTabBar(title: L10n.TabBar.catalog, image: DSIcon.TabBar.catalog, tag: 0)
    }

}

// MARK: - ItemTabBarFactory
extension CatalogFactoryImp: ItemTabBarFactory {}
