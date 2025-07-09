//
//  CatalogSearchTextField.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 07.07.2025.
//

import UIKit

// MARK: - CatalogSearchTextField
final class CatalogSearchTextField: UITextField {
    // MARK: - PROPERTIES
    private let padding: CGFloat
    
    // MARK: - INIT
    init(padding: CGFloat) {
        self.padding = padding
        
        super.init(frame: .zero)
        configure()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIFE CYCLE
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    // MARK: - METHODS
    func setupRightView() {
        let container = makeRightViewContainer()
        self.setRightView(container)
    }
    
    // MARK: - PRIVATE METHODS
    private func configure() {
        self.setLeftPadding(DSSpasing.large)
        self.backgroundColor = UIColor.DS.Background.secondary
        self.layer.cornerRadius = 30
    }
    
    private func makeRightViewContainer() -> UIView {
        let widthContainer = self.frame.width * DSLayout.CatalogSearchTextFieldLayot.widthRatio + padding
        let heightImageView = self.frame.height * DSLayout.CatalogViewControllerLayout.seatchButtonHeightRatio
        
        let height = self.frame.height * 0.5
        
        let container = UIView(frame: .init(x: 0, y: 0, width: widthContainer, height: height))
        let imageView = UIImageView(frame: .init(x: 0, y: 0, width: heightImageView, height: heightImageView))
        imageView.image = UIImage.DS.Buttons.search
        
        container.addSubview(imageView)
        
        return container
    }
}
