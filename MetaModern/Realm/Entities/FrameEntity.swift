//
//  FrameEntity.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 28.06.2025.
//

import Foundation
import RealmSwift

// MARK: - FrameEntity
final class FrameEntity: Object {
    @Persisted(primaryKey: true) var _id = UUID()
    @Persisted var name: String
    @Persisted var author: String?
    @Persisted var details: String?
    @Persisted var videoURL: String?
    @Persisted var isFavourite: Bool
    @Persisted var shouldBeTested: Bool
    @Persisted var correctGuessesCount: Int
    
    // ONE-TO-MANY RELATIONSHEEP
    @Persisted var cards: List<CardEntity>
    
    // INVERSE REALTIONSHEEP
    @Persisted(originProperty: "frames") private var category: LinkingObjects<CategoryEntity>
    
    // INIT
    convenience init(_id: UUID, name: String, author: String?, details: String?, videoURL: String?, isFavourite: Bool, shouldBeTested: Bool, correctGuessesCount: Int, cards: List<CardEntity>) {
        self.init()
        self._id = _id
        self.name = name
        self.author = author
        self.details = details
        self.videoURL = videoURL
        self.isFavourite = isFavourite
        self.shouldBeTested = shouldBeTested
        self.correctGuessesCount = correctGuessesCount
        self.cards = cards
    }
}
