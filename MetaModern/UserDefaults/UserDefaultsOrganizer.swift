//
//  UserDefaultsOrganizer.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 21.06.2025.
//

import Foundation

enum UserDefaultsOrganizer {
    static let hasSeenOnboarding = UserDefaultsUnityManager<Bool>(key: UserDefaultsKeys.hasSeenOnboarding.rawValue, defaultValue: true)
    static let hasDatabaseLoaded = UserDefaultsUnityManager(key: UserDefaultsKeys.hasDatabaseLoaded.rawValue, defaultValue: false)
}
