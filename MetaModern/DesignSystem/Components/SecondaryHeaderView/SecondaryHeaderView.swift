//
//  SecondaryHeaderView.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 22.06.2025.
//

import UIKit

// MARK: - SecondaryHeaderView
final class SecondaryHeaderView: UIView {
    // MARK: - GUI
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let horizontalButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = DSSpasing.small
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = DSLabel()
        label.font = DSFont.title2(weight: .bold)
        
        return label
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        configure()
        configureHorizontalStackViewLayout()
        configureTitleLabelLayout()
        configureSpacerViewLayout()
        configureHorizontalButtonsStackViewLayout()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setTitle(_ text: String?) {
        self.titleLabel.text = text
    }
    
    func appendViewToButtonsStackView(_ view: UIView) {
        self.horizontalButtonsStackView.addArrangedSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalTo: self.horizontalStackView.widthAnchor, multiplier: DSLayout.SecondaryHeaderViewLayout.horizontalButtonsStackViewItemWidthRatio)
        ])
    }
    
    // MARK: - Private Methods
    private func configure() {
        self.backgroundColor = UIColor.DS.Background.secondary
    }
}

// MARK: - Configure Layout
private extension SecondaryHeaderView {
    func configureHorizontalStackViewLayout() {
        self.addSubview(horizontalStackView)
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DSSpasing.leading),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: DSSpasing.trailing),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configureTitleLabelLayout() {
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.horizontalStackView.addArrangedSubview(titleLabel)
    }
    
    func configureSpacerViewLayout() {
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.horizontalStackView.addArrangedSubview(spacerView)
    }
    
    func configureHorizontalButtonsStackViewLayout() {
        horizontalButtonsStackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.horizontalStackView.addArrangedSubview(horizontalButtonsStackView)
    }
}
