//
//  EmptyLabelState.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 20.07.2025.
//

import Foundation

enum EmptyLabelState {
    case search
    case favourites
    
    var title: String {
        switch self {
        case .search:
            L10n.Catalog.emptyLabelCatalogTitle
        case .favourites:
            L10n.Catalog.emptyLabelFavouritesTitle
        }
    }
}
