//
//  Card.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 28.06.2025.
//

import Foundation

// MARK: - Card
struct Card {
    var id: UUID
    var name: String
    
    // MARK: - INIT
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
