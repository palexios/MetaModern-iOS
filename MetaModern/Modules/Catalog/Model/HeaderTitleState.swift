//
//  HeaderTitleState.swift
//  MetaModern
//
//  Created by Александр Павлицкий on 20.07.2025.
//

import Foundation

enum HeaderTitleState {
    case catalog
    case favourites
    case search
    
    var title: String {
        switch self {
        case .catalog:
            L10n.Catalog.headerTitleStateCatalog
        case .favourites:
            L10n.Catalog.headerTitleStateFavourites
        case .search:
            L10n.Catalog.headerTitleStateSearch
        }
    }
}
