//
//  UITextField+Ext.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 07.07.2025.
//

import UIKit

extension UITextField {
    func setLeftPadding(_ padding: CGFloat) {
        let view = UIView(frame: .init(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = view
        self.leftViewMode = .always
    }
    
    func setRightView(_ view: UIView) {
        self.rightView = view
        self.rightViewMode = .always
    }
}
