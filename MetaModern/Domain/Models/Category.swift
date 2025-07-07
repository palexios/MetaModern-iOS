//
//  Category.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 28.06.2025.
//

import Foundation

// MARK: - Category
struct Category: IdentifiableEquatable {
    var id: UUID
    var name: String
    var frames: [Frame]
    
    // MARK: - INIT
    init(id: UUID = UUID(), name: String, frames: [Frame]) {
        self.id = id
        self.name = name
        self.frames = frames
    }
}
