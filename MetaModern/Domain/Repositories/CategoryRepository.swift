//
//  CategoryRepository.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 30.06.2025.
//

import Foundation
import Combine

protocol CategoryRepository {
    func fetch(text: String, isFavourite: Bool, searchType: SearchType?) -> AnyPublisher<[Category], Never>
    func fetchAll(isFavourite: Bool) -> AnyPublisher<[Category], Never>
    func create(categories: [Category]) -> AnyPublisher<Void, Error>
}
