//
//  RootItems.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import Foundation

let NO_ICON = "none"

enum RootItems: Int, Hashable {
    
    case dictionary
    case alphabet
    case for_children
    case settings
    
    var icon: String {
        switch self {
        case .dictionary: return "icons/dictionary"
        case .alphabet: return "icons/alphabet"
        case .for_children: return "icons/child"
        case .settings: return "gearshape"
        }
    }
    
    var title: String {
        switch self {
        case .dictionary: return String(localized: "title_dictionary", comment: "TabBar dictionary")
        case .alphabet: return String(localized: "title_alphabet", comment: "TabBar alphabet")
        case .for_children: return String(localized: "title_children", comment: "TabBar For kids")
        case .settings: return String(localized: "Settings", comment: "TabBar Menu")
        }
    }
}
