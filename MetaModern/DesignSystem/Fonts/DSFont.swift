//
//  DSFont.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 28.06.2025.
//

import UIKit

// MARK: - DSFont
public enum DSFont {
    ///34
    public static func largeTitle(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 34, weight: weight)
    }
    ///28
    public static func title1(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 28, weight: weight)
    }
    ///22
    public static func title2(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 22, weight: weight)
    }
    ///20
    public static func title3(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 20, weight: weight)
    }
    ///17
    public static func headline(weight: UIFont.Weight = .semibold) -> UIFont {
        UIFont.systemFont(ofSize: 17, weight: weight)
    }
    ///17
    public static func bold(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 17, weight: weight)
    }
    ///16
    public static func callout(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 16, weight: weight)
    }
    ///15
    public static func subhead(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 15, weight: weight)
    }
    ///13
    public static func footnote(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 13, weight: weight)
    }
}
