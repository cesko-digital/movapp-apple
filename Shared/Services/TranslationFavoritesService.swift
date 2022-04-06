//
//  FavoritesService.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 05.04.2022.
//

import Foundation


fileprivate let userDefaultsKey = "favorite.translations"
fileprivate typealias FavoritesTranslationsStore = [String: [String: String]]

class TranslationFavoritesService: ObservableObject {
    
    /**
     A map of favorited translations by language pack and translation id
     [language pack][translationId] = translation id
     */
    private var favoritedTranslationsByLanguage: FavoritesTranslationsStore = [:]
    
    /**
    In near future we can provide interface for storing favorites, now we are using UserDefaults (we could do a wrapper that hooks on changes and sends to to backend, etc)
     */
    init () {
        if let favoritesFromUserDefaults = UserDefaults.standard.object(forKey: userDefaultsKey) as? FavoritesTranslationsStore {
            favoritedTranslationsByLanguage = favoritesFromUserDefaults
        }
    }
    
    func getFavorites( language: SetLanguage) -> [String] {
        guard let favorites = favoritedTranslationsByLanguage[language.language.from] else {
            return []
        }
        
        // Return only ids - map not needed
        return Array(favorites.values)
    }
    
    
    func isFavorited(_ translation: Translation, language: SetLanguage) -> Bool {
        let isFavorited = favoritedTranslationsByLanguage[language.language.from]?[translation.id]
        guard isFavorited != nil else {
            return false
        }
        
        return true
    }
    
    /**
     Updates the isFavorite state on the translation and stores the change
     */
    func setIsFavorited(_ isFavorited: Bool, translation: Translation, language: SetLanguage) {
        translation.isFavorited = isFavorited
        
        setIsFavorited(isFavorited, translationId: translation.id, language: language)
    }
    
    /**
     Sets favorte state by given id - will not update translation object (UI will not be updated)
     */
    func setIsFavorited(_ isFavorited: Bool, translationId: String, language: SetLanguage) {
        if favoritedTranslationsByLanguage[language.language.from] == nil {
            favoritedTranslationsByLanguage[language.language.from] = [:]
        }
        
        if isFavorited == true {
            favoritedTranslationsByLanguage[language.language.from]![translationId] = translationId
        } else {
            favoritedTranslationsByLanguage[language.language.from]!.removeValue(forKey:translationId)
        }
        
        UserDefaults.standard.setValue(favoritedTranslationsByLanguage, forKey: userDefaultsKey)
    }
}
