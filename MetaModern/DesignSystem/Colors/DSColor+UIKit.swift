//
//  DSColor+UIKit.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 22.06.2025.
//

import UIKit

// MARK: - DSColor
public extension UIColor {
    // MARK: - DS
    enum DS {
        
        // MARK: - Text
        enum Text {
            static let darkBlue = UIColor(named: DSColor.Text.darkBlue)!
            static let gray = UIColor(named: DSColor.Text.gray)!
            static let purple = UIColor(named: DSColor.Text.purple)!
        }
        // MARK: - Tint
        enum Tint {
            static let primary = UIColor(named: DSColor.Tint.primary)!
        }
        // MARK: - Background
        enum Background {
            static let primary = UIColor(named: DSColor.Background.primary)!
            static let secondary = UIColor(named: DSColor.Background.secondary)!
            static let white = UIColor(named: DSColor.Background.white)!
            static let cyan = UIColor(named: DSColor.Background.cyan)!
        }
    }
}
