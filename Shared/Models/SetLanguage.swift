//
//  LanguageSetting.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.04.2022.
//

import Foundation

/**
 Indicates current language settings displayed to user -> indicates which language want to use and which way should be display (from <- to or to -> from)
 */
struct SetLanguage: Identifiable {
    
    let id: String
    let language: Language
    
    /**
     Indicates if we should swap X_from with X_to (reuses same data file)
     */
    let flipFromWithTo: Bool
    
    init(language: Language, flipFromWithTo: Bool) {
        
        self.language = language
        self.flipFromWithTo = flipFromWithTo
        
        var fromTo = [language.from.rawValue, language.to.rawValue]
        if flipFromWithTo {
            fromTo = fromTo.reversed()
        }
        
        id = fromTo.joined(separator: "->")
    }
    
    var title: String {
        return id
    }
    
    var languagePrefix: Languages {
        if flipFromWithTo {
            return language.to
        }
        
        return language.from
    }
}

extension SetLanguage: Hashable {
    
    static func == (lhs: SetLanguage, rhs: SetLanguage) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/**
 Built the language in type strict way so we can use them in previews.
 */

let csUkLanguage = Language(from: Languages.cs, to: Languages.uk)

extension SetLanguage {

    static let csUk = SetLanguage(language: csUkLanguage, flipFromWithTo: false)
    static let ukCs = SetLanguage(language: csUkLanguage, flipFromWithTo: true)
    
    static let allCases = [csUk, ukCs]
}

typealias SetLanguages = [SetLanguage]




