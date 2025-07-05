//
//  FactoryProtocol.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 22.06.2025.
//

import UIKit

// MARK: - FactoryProtocol
protocol FactoryProtocol {
    func makeViewController() -> UIViewController
    func makeItemTabBar() -> UITabBarItem
}
