//
//  OnboardingCoordinator.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 21.06.2025.
//

import UIKit

// MARK: - OnboardingCoordinator
final class OnboardingCoordinator: Coordinator {
    // MARK: - Properties
    var navigationController: UINavigationController
    
    var factory: OnboardingFactory
    
    // MARK: - Init
    init(navigationController: UINavigationController, factory: OnboardingFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    // MARK: - Methods
    func start() {
        let vc = factory.makeOnboardingViewController()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
}
