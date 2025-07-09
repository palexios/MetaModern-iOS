//
//  CategoryRepositoryImp.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 30.06.2025.
//

import Foundation
import RealmSwift
import Combine

final class CategoryRepositoryImp: CategoryRepository {
    func create(categories: [Category]) -> AnyPublisher<Void, any Error> {
        Future<Void, Error> { promise in
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2) {
                do {
                    let realm = try Realm()
                    try realm.write {
                        categories.forEach {
                            let entity = CategoryEntity.fromDomain($0)
                            realm.add(entity)
                        }
                    }
                    DispatchQueue.main.async {
                        promise(.success(()))
                    }
                } catch {
                    print("Realm creating error")
                    DispatchQueue.main.async {
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// Fetching all categories from Realm Database
    func fetchAll() -> AnyPublisher<[Category], Never> {
        Future<[Category], Never> { promise in
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2) {
                do {
                    let realm = try Realm()
                    let entityObjects = Array(realm.objects(CategoryEntity.self))
                    let objects = entityObjects.map { $0.toDomain() }
                    
                    DispatchQueue.main.async {
                        promise(.success(objects))
                    }
                    
                } catch {
                    print("Realm fetching error")
                    
                    DispatchQueue.main.async {
                        promise(.success([]))
                    }
                    
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// Fetches all categories with filtred frames based on the searched text and search type
    func fetch(text: String, searchType: SearchType? = nil) -> AnyPublisher<[Category], Never> {
        
        // CategoryEntity-level filters
        let categoryAuthorFilter: (CategoryEntity) -> Bool = {
            $0.frames.contains(where: {$0.author?.lowercased().contains(text) == true})
        }
        
        let categoryFrameNameFilter: (CategoryEntity) -> Bool = {
            $0.frames.contains(where: { $0.name.lowercased() == text})
        }
        
        let categoryCardNameFilter: (CategoryEntity) -> Bool = {
            $0.frames.contains(where: { $0.cards.contains(where: { $0.name.lowercased().contains(text)} )} )
        }
        
        let categoryCombinedFilter: (CategoryEntity) -> Bool = { category in
            return categoryAuthorFilter(category) || categoryFrameNameFilter(category) || categoryCardNameFilter(category)
        }
        
        // Frame-level filters
        let frameAuthorFilter: (Frame) -> Bool = {
            $0.author?.lowercased().contains(text) == true
        }

        let frameNameFilter: (Frame) -> Bool = {
            $0.name.lowercased().contains(text)
        }
        
        let frameCardNameFilter: (Frame) -> Bool = {
            $0.cards.contains(where: {$0.name.lowercased().contains(text)})
        }
        
        let frameCombinedFilter: (Frame) -> Bool = { frame in
            return frameAuthorFilter(frame) || frameNameFilter(frame) || frameCardNameFilter(frame)
        }
        
        return Future<[Category], Never> { promise in
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let realm = try Realm()
                    var categoryEntities: [CategoryEntity] = []
                    
                    // Fetch CategoryEntities based on CategoryEntity-level filters
                    if let searchType {
                        
                        let categoryFilter = switch searchType {
                        case .author:
                            categoryAuthorFilter
                        case .frame:
                            categoryFrameNameFilter
                        case .card:
                            categoryCardNameFilter
                        }
                        
                        categoryEntities = Array(realm.objects(CategoryEntity.self).filter(categoryFilter))
                        
                    } else {
                        categoryEntities = Array(realm.objects(CategoryEntity.self).filter(categoryCombinedFilter))
                    }
                    
                    var categories = categoryEntities.map { $0.toDomain() }
                    
                    // Filter Category frames based on Frame-level filters
                    if let searchType {
                        
                        let frameFilter = switch searchType {
                        case .author:
                            frameAuthorFilter
                        case .frame:
                            frameNameFilter
                        case .card:
                            frameCardNameFilter
                        }
                        
                        categories = categories.map { category in
                            let frames = category.frames.filter(frameFilter)
                            
                            return Category(id: category.id, name: category.name, frames: frames)
                        }
                    } else {
                        categories = categories.map { category in
                            let frames = category.frames.filter(frameCombinedFilter)
                            
                            return Category(id: category.id, name: category.name, frames: frames)
                        }
                    }
                    
                    // Removing Categories with empty frames
                    categories = categories.filter { !$0.frames.isEmpty}
                    
                    promise(.success(categories))
                } catch {
                    print("Realm search fetch error")
                    promise(.success([]))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
