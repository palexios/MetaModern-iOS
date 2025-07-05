//
//  Frame.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 28.06.2025.
//

import Foundation

// MARK: - Frame
struct Frame {
    var id: UUID
    var name: String
    var author: String?
    var details: String?
    var videoURL: String?
    var isFavourite: Bool
    var shouldBeTested: Bool
    var correctGuessesCount: Int
    
    var cards: [Card]
    
    // MARK: - INIT
    init(id: UUID = UUID(), name: String, author: String?, details: String?, videoURL: String? = nil, isFavourite: Bool = false, shouldBeTested: Bool = true, correctGuessesCount: Int = 0, cards: [Card]) {
        self.id = id
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
