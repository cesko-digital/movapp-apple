//
//  FavoritesService.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 05.04.2022.
//

import Foundation

typealias FavoritesTranslationsStore = [String: [String: String]]

class TranslationFavoritesService: ObservableObject {
    
    private let userDefaultsKey = "favorite.translations"
    
    /**
     A map of favorited translations by language pack and translation id
     [language pack][translationId] = translation id
     */
    @Published private(set) var favoritedTranslationsByLanguage: FavoritesTranslationsStore = [:] {
        didSet {
            UserDefaults.standard.setValue(favoritedTranslationsByLanguage, forKey: userDefaultsKey)
        }
    }
    
    /**
    In near future we can provide interface for storing favorites, now we are using UserDefaults (we could do a wrapper that hooks on changes and sends to to backend, etc)
     */
    init () {
        if let favoritesFromUserDefaults = UserDefaults.standard.object(forKey: userDefaultsKey) as? FavoritesTranslationsStore {
            favoritedTranslationsByLanguage = favoritesFromUserDefaults
        }
    }
    
    func getFavorites( language: SetLanguage) -> [Dictionary.TranslationID] {
        guard let favorites = favoritedTranslationsByLanguage[language.language.from.rawValue] else {
            return []
        }
        
        // Return only ids - map not needed
        return Array(favorites.values)
    }
    
    func isFavorited(_ translation: Dictionary.Translation, language: SetLanguage) -> Bool {
        let isFavorited = favoritedTranslationsByLanguage[language.language.from.rawValue]?[translation.id]
        guard isFavorited != nil else {
            return false
        }
        
        return true
    }

    /**
     Sets favorte state by given id - will not update translation object (UI will not be updated)
     */
    func setIsFavorited(_ isFavorited: Bool, translationId: Dictionary.TranslationID, language: SetLanguage) {
        if favoritedTranslationsByLanguage[language.language.from.rawValue] == nil {
            favoritedTranslationsByLanguage[language.language.from.rawValue] = [:]
        }
        
        if isFavorited == true {
            favoritedTranslationsByLanguage[language.language.from.rawValue]![translationId] = translationId
        } else {
            favoritedTranslationsByLanguage[language.language.from.rawValue]!.removeValue(forKey:translationId)
        }
    }
}
