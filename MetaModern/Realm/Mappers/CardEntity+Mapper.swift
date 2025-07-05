//
//  CardEntity+Mapper.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 30.06.2025.
//

import Foundation
import RealmSwift

extension CardEntity {
    func toDomain() -> Card {
        Card(id: self._id,
             name: self.name)
    }
    
    static func fromDomain(_ card: Card) -> CardEntity {
        CardEntity(_id: card.id, name: card.name)
    }
}
