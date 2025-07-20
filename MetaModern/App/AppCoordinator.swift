//
//  AppCoordinator.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 21.06.2025.
//

import UIKit
import Combine

// MARK: - AppCoordinator
final class AppCoordinator: Coordinator {
    // MARK: - Properties
    var navigationController: UINavigationController
    
    private let hasSeenOnboardingUD: UserDefaultsUnityManager<Bool>
    private let hasDatabaseLoadedUD: UserDefaultsUnityManager<Bool>
    
    private let categoryRepository: CategoryRepository
    private let frameRepository: FrameRepository
    
    private let factory: AppFactory
    private let window: UIWindow?
    
    var cancel = Set<AnyCancellable>()
    
    private var activeCoordinator: Coordinator?
    
    // MARK: - Init
    init(navigationController: UINavigationController,
         hasSeenOnboardingUD: UserDefaultsUnityManager<Bool> = UserDefaultsOrganizer.hasSeenOnboarding,
         hasDatabaseLoaded: UserDefaultsUnityManager<Bool> = UserDefaultsOrganizer.hasDatabaseLoaded,
         categoryRepository: CategoryRepository,
         frameRepository: FrameRepository,
         factory: AppFactory,
         window: UIWindow?) {
        
        self.navigationController = navigationController
        self.hasSeenOnboardingUD = hasSeenOnboardingUD
        self.hasDatabaseLoadedUD = hasDatabaseLoaded
        self.categoryRepository = categoryRepository
        self.frameRepository = frameRepository
        self.factory = factory
        self.window = window
    }
    
    // MARK: - Methods
    func start() {
        guard let hasSeenOnboarding = hasSeenOnboardingUD.read(),
              let hasDatabaseLoaded = hasDatabaseLoadedUD.read()
        else { return }
        
        configureWindow()
        
        if !hasDatabaseLoaded {
            
            categoryRepository.create(categories: preloadedData).sink { completion in
                switch completion {
                case .finished:
                    self.hasDatabaseLoadedUD.save(data: true)
                    hasSeenOnboarding ? self.startMainTabBarCoordinator() : self.startOnboardingCoordinator()
                case .failure(_):
                    return
                }
            } receiveValue: { _ in }
                .store(in: &cancel)
            
        } else {
            hasSeenOnboarding ? startMainTabBarCoordinator() : startOnboardingCoordinator()
        }
    }
    
    // MARK: - Private Methods
    private func startOnboardingCoordinator() {
        self.activeCoordinator = factory.makeOnboardingCoordinator(navigationController: self.navigationController)
        activeCoordinator?.start()
    }
    
    private func startMainTabBarCoordinator() {
        self.activeCoordinator = factory.makeMainTabBarCoordinator(navigationController: self.navigationController, categoryRepository: categoryRepository, frameRepository: frameRepository)
        activeCoordinator?.start()
    }
    
    private func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}
