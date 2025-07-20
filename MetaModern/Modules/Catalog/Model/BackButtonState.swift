//
//  BackButtonState.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 10.07.2025.
//

import Foundation

// MARK: - BackButtonState
enum BackButtonState {
    case reset
    case toCatalog
    case toFavourites
    case none
    
    var title: String {
        switch self {
        case .reset:
            L10n.Catalog.backButtonResetState
        case .toCatalog:
            L10n.Catalog.backButtonToCatalogState
        case .toFavourites:
            L10n.Catalog.backButtonToFavouritesState
        case .none:
            ""
        }
    }
}
