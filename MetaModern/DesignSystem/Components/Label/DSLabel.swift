//
//  DSLabel.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 22.06.2025.
//

import UIKit

// MARK: - DSLabel
final class DSLabel: UILabel {
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setup() {
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.6
    }
}
