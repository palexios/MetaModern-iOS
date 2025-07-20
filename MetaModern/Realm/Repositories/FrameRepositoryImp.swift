//
//  FrameRepositoryImp.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 13.07.2025.
//

import Foundation
import RealmSwift
import Combine

// MARK: - FrameRepositoryImp
final class FrameRepositoryImp: FrameRepository {
    func updateFavourite(for frame: Frame) -> AnyPublisher<Frame, Error> {
        Future<Frame, Error> { promise in
            DispatchQueue.global().async {
                do {
                    let realm = try Realm()
                    guard let frameEntity = realm.objects(FrameEntity.self).first(where: { $0._id == frame.id} ) else {
                        promise(.failure(NSError()))
                        return
                    }
                    
                    try realm.write {
                        frameEntity.isFavourite.toggle()
                    }
                    
                    let frame = frameEntity.toDomain()
                    
                    promise(.success(frame))
                } catch {
                    print("Realm updating error")
                    promise(.failure(NSError()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
