//
//  CategoryEntity.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 28.06.2025.
//

import Foundation
import RealmSwift

// MARK: - CategoryEntity
final class CategoryEntity: Object {
    @Persisted(primaryKey: true) var _id = UUID()
    @Persisted var name: String
    
    // ONET-TO-MANY RELATIONSHEEP
    @Persisted var frames: List<FrameEntity>
    
    // INIT
    convenience init(_id: UUID, name: String, frames: List<FrameEntity>) {
        self.init()
        
        self._id = _id
        self.name = name
        self.frames = frames
    }
}
