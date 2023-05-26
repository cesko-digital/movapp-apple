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
    case exercise
    case alphabet
    case for_children
    case settings

    var icon: String {
        switch self {
        case .dictionary: return "icons/dictionary"
        case .exercise: return "figure.highintensity.intervaltraining" // TODO: Change icon
        case .alphabet: return "icons/alphabet"
        case .for_children: return "icons/child"
        case .settings: return "gearshape"
        }
    }

    var title: String {
        switch self {
        case .dictionary: return String(localized: "title_dictionary", comment: "TabBar dictionary")
        case .exercise: return String(localized: "title_exercise", comment: "TabBar exercise")
        case .alphabet: return String(localized: "title_alphabet", comment: "TabBar alphabet")
        case .for_children: return String(localized: "title_children", comment: "TabBar For kids")
        case .settings: return String(localized: "settings", comment: "TabBar Menu")
        }
    }
}
