//
//  DSColor.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 22.06.2025.
//

import Foundation

// MARK: - DSColor
public enum DSColor {
    // MARK: - Shared
    enum Shared {
        static let white = "dsWhite"
        static let purple = "dsPurple"
        static let gray4 = "dsGray4"
        static let gray5 = "dsGray5"
        static let darkBlue = "dsDarkBlue"
        static let cyan = "dsCyan"
    }
    
    // MARK: - Text
    enum Text {
        static let darkBlue = Shared.darkBlue
        static let gray = Shared.gray4
        static let purple = Shared.purple
    }
    
    // MARK: - Tint
    enum Tint {
        static var primary = Shared.purple
    }
    
    // MARK: - Background
    enum Background {
        static var primary: String { Shared.white }
        static var secondary: String { Shared.gray5}
        static var white: String { Shared.white }
        static var cyan: String { Shared.cyan }
    }
}
