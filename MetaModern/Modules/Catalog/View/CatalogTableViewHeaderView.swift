//
//  CatalogTableViewHeaderView.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 03.07.2025.
//

import UIKit

// MARK: - CatalogTableViewHeaderView
final class CatalogTableViewHeaderView: UIView {
    // MARK: - GUI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.DS.Text.purple
        label.font = DSFont.title3(weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - INIT
    init() {
        super.init(frame: .zero)
        
        configure()
        configureTitleLabelLayout()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - METHODS
    func setup(title: String) {
        self.titleLabel.text = "Очень очень очень очень длинный текст"
        self.titleLabel.text = title
    }
    
    // MARK: - PRIVATE METHODS
    private func configure() {
        self.backgroundColor = UIColor.DS.Background.white
    }
}

// MARK: - CONFIGURE LAYOUT
private extension CatalogTableViewHeaderView {
    func configureTitleLabelLayout() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: DSSpasing.medium),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DSSpasing.leading),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: DSSpasing.trailing),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -DSSpasing.medium),
        ])
    }
}
