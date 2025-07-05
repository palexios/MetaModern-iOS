//
//  UserDefaultsUnityManager.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 21.06.2025.
//

import Foundation

// MARK: - UserDefaultsUnityManager
struct UserDefaultsUnityManager<T> {
    // MARK: - Properties
    private let userDefaults: UserDefaults
    private let key: String
    
    // MARK: - Init
    init(userDefaults: UserDefaults = UserDefaults.standard, key: String, defaultValue: T? = nil) {
        self.userDefaults = userDefaults
        self.key = key
        
        guard let defaultValue else { return }
        setDefaultValue(defaultValue)
    }
    
    // MARK: - Methods
    func save(data: T?) {
        userDefaults.setValue(data, forKey: self.key)
    }
    
    func read() -> T? {
        userDefaults.value(forKey: self.key) as? T
    }
    
    func delete() {
        userDefaults.removeObject(forKey: self.key)
    }
    
    // MARK: - Private Methods
    private func setDefaultValue(_ value: T) {
        userDefaults.register(defaults: [
            key: value
        ])
    }
}
