//
//  CatalogFactory.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 22.06.2025.
//

import UIKit

protocol CatalogFactory {
    func makeCatalogViewController(categoryRepository: CategoryRepository) -> UIViewController
    func makeCatalogItemTabBar() -> UITabBarItem
}
