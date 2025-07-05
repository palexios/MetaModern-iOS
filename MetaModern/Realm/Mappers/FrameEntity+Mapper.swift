//
//  FrameEntity+Mapper.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 30.06.2025.
//

import Foundation
import RealmSwift

extension FrameEntity {
    func toDomain() -> Frame {
        Frame(id: self._id,
              name: self.name,
              author: self.author,
              details: self.details,
              videoURL: self.videoURL,
              isFavourite: self.isFavourite,
              shouldBeTested: self.shouldBeTested,
              correctGuessesCount: self.correctGuessesCount,
              cards: self.cards.map { $0.toDomain() })
    }
    
    static func fromDomain(_ frame: Frame) -> FrameEntity {
        let list = List<CardEntity>()
        list.append(objectsIn: frame.cards.map { CardEntity.fromDomain($0) })
        
        return FrameEntity(_id: frame.id,
                           name: frame.name,
                           author: frame.author,
                           details: frame.details,
                           videoURL: frame.videoURL,
                           isFavourite: frame.isFavourite,
                           shouldBeTested: frame.shouldBeTested,
                           correctGuessesCount: frame.correctGuessesCount,
                           cards: list
        )
    }
}
