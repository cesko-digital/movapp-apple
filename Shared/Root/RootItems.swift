//
//  RootItems.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import Foundation

let NO_ICON = "none"

enum RootItems: Int {
    
    case dictionary = 0
    case alphabet
    case for_chidlren
    case menu
    
    var icon: String {
        switch self {
        case .dictionary: return NO_ICON
            case .alphabet: return NO_ICON
            case .for_chidlren: return NO_ICON
            case .menu: return "menu"
        }
    }
    
    var title: String {
        switch self {
        case .dictionary: return String(localized: "tabbar.dictionary", comment: "TabBar dictionary")
            case .alphabet: return String(localized: "tabbar.alphabet", comment: "TabBar aklphabet - use shortcut A-Z")
            case .for_chidlren: return String(localized: "tabbar.for_kids", comment: "TabBar For kids")
            case .menu: return String(localized: "tabbar.menu", comment: "TabBar Menu")
        }
    }
    
    var cacheView: Bool {
        return true
    }
}
