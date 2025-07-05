//
//  CardEntity.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 28.06.2025.
//

import Foundation
import RealmSwift

// MARK: - CardEntity
final class CardEntity: Object {
    @Persisted(primaryKey: true) var _id = UUID()
    @Persisted var name: String
    
    // INVERSE RELATIONSHEEP
    @Persisted(originProperty: "cards") private var frame: LinkingObjects<FrameEntity>
    
    // INIT
    convenience init(_id: UUID, name: String) {
        self.init()
        
        self._id = _id
        self.name = name
    }
}
