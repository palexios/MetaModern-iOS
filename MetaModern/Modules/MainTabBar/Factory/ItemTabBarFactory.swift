//
//  ItemTabBarFactory.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 22.06.2025.
//

import UIKit

protocol ItemTabBarFactory {}

extension ItemTabBarFactory {
    func makeItemTabBar(title: String, image: String, tag: Int) -> UITabBarItem {
        UITabBarItem(title: title, image: UIImage(named: image), tag: tag)
    }
}
