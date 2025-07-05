//
//  DSIcon+UIKit.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 22.06.2025.
//

import UIKit

public extension UIImage {
    // MARK: - DS
    enum DS {
        // MARK: - Buttons
        enum Buttons {
            static let switchOn = UIImage(named: DSIcon.Buttons.switchOn)
            static let switchOff = UIImage(named: DSIcon.Buttons.switchOff)
            static let search = UIImage(named: DSIcon.Buttons.search)
            static let heartOff = UIImage(named: DSIcon.Buttons.heartOff)
            static let heartOn = UIImage(named: DSIcon.Buttons.heartOn)
        }
        // MARK: - TabBar
        enum TabBar {
            static let catalog = UIImage(named: DSIcon.TabBar.catalog)
        }
    }
}
