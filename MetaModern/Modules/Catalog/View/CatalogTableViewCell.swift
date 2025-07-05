//
//  CatalogTableViewCell.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 28.06.2025.
//

import UIKit

// MARK: - CatalogTableViewCell
final class CatalogTableViewCell: UITableViewCell {
    // MARK: - GUI
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = DSLabel()
        label.numberOfLines = 2
        label.font = DSFont.title3()
        label.textColor = UIColor.DS.Text.darkBlue
        
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = DSLabel()
        label.font = DSFont.callout()
        label.textColor = UIColor.DS.Text.gray
        
        return label
    }()

    private let heartImageView = UIImageView()
    
    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        configureHorizontalStackViewLayout()
        configureVerticalStackViewLayout()
        configureTitleLabelLayout()
        configureAuthorLabelLayout()
        configureHeartImageViewLayout()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - METHODS
    func setup(_ frame: Frame) {
        self.titleLabel.text = frame.name
        self.authorLabel.text = frame.author
        
        let image = frame.isFavourite ? UIImage.DS.Buttons.heartOn : UIImage.DS.Buttons.heartOff
        self.heartImageView.image = image
    }
    
    // MARK: - PRIVATE METHODS
    private func configure() {
        self.backgroundView?.backgroundColor = UIColor.DS.Background.white
    }
}

// MARK: - LAYOUT
private extension CatalogTableViewCell {
    func configureHorizontalStackViewLayout() {
        self.contentView.addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: DSSpasing.leading),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: DSSpasing.trailing),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -DSSpasing.xSmall)
        ])
    }
    
    func configureVerticalStackViewLayout() {
        self.horizontalStackView.addArrangedSubview(verticalStackView)
    }
    
    func configureTitleLabelLayout() {
        titleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.verticalStackView.addArrangedSubview(titleLabel)
    }
    
    func configureAuthorLabelLayout() {
        authorLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.verticalStackView.addArrangedSubview(authorLabel)
    }
    
    func configureHeartImageViewLayout() {
        let container = UIView()
        container.addSubview(heartImageView)
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heartImageView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: DSLayout.CatalogTableViewCellLayout.heartButtonWidthRatioToContainer),
            heartImageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: DSLayout.CatalogTableViewCellLayout.heartButtonHeightRatioToContainer),
            heartImageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            heartImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        horizontalStackView.addArrangedSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalTo: self.horizontalStackView.widthAnchor, multiplier: DSLayout.CatalogTableViewCellLayout.heartButtonCointainerWidthRatio)
        ])
        
        heartImageView.image = UIImage.DS.Buttons.heartOff
    }
}
