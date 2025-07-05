//
//  MainTabBarController.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 21.06.2025.
//

import UIKit

// MARK: - MainTabBarController
final class MainTabBarController: UITabBarController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        self.view.backgroundColor = UIColor.DS.Background.primary
        self.tabBar.backgroundColor = UIColor.DS.Background.secondary
        self.tabBar.tintColor = UIColor.DS.Tint.primary
    }
}
