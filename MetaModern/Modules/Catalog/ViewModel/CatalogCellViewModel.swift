//
//  CatalogCellViewModel.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 14.07.2025.
//

import UIKit
import Combine

// MARK: - CatalogCellViewModel
struct CatalogCellViewModel {
    // MARK: - PROPERTIES
    let frame: Frame
    var subscription: AnyCancellable?
    
    // MARK: - SUBJECTS
    var heartImageViewTappedSubject = PassthroughSubject<Frame, Never>()
    
    // MARK: - INIT
    init(frame: Frame) {
        self.frame = frame
    }
    
    // MARK: - METHODS
    func heartImageViewTapped() {
        heartImageViewTappedSubject.send(self.frame)
    }
}
