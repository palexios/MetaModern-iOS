//
//  IdentifiableEquatable.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 05.07.2025.
//

import Foundation

protocol IdentifiableEquatable: Equatable {
    var id: UUID { get set }
}

extension IdentifiableEquatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
