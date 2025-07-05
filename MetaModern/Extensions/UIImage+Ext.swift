//
//  UIImage+Ext.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 28.06.2025.
//

import UIKit

extension UIImage {
    func scaled(to size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: .init(origin: .zero, size: size))
        }
    }
}
