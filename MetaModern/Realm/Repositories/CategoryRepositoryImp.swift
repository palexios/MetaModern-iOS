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
    
}
