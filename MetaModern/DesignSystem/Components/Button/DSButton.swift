//
//  DSButton.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 07.07.2025.
//

import UIKit

// MARK: - DSButton
final class DSButton: UIButton {
    // MARK: - INIT
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    private func configure() {
        self.backgroundColor = UIColor.DS.Background.cyan
        self.titleLabel?.font = DSFont.title3(weight: .bold)
    }
}
