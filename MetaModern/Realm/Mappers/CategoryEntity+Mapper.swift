//
//  CategoryEntity+Mapper.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 30.06.2025.
//

import Foundation
import RealmSwift

extension CategoryEntity {
    func toDomain() -> Category {
        Category(id: self._id,
                 name: self.name,
                 frames: self.frames.map { $0.toDomain() })
    }
    
    static func fromDomain(_ category: Category) -> CategoryEntity {
        let list = List<FrameEntity>()
        list.append(objectsIn: category.frames.map { FrameEntity.fromDomain($0) })
        
        return CategoryEntity(_id: category.id,name: category.name,frames: list)
    }
}
