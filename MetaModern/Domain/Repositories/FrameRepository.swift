//
//  FrameRepository.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 13.07.2025.
//

import Foundation
import Combine

protocol FrameRepository {
    func updateFavourite(for frame: Frame) -> AnyPublisher<Frame, Error>
}
