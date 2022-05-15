//
//  FavoritesService.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 05.04.2022.
//

import Foundation

private func migrateFromInitialVersionToAirtable (_ favoritedTranslationsByLanguage: FavoritesTranslationsStore, dictionaryDataStore: DictionaryDataStore) -> FavoritesTranslationsStore? {
    
    if favoritedTranslationsByLanguage.isEmpty {
        return nil
    }
    
    // Initial version had only one language -- CS
    for (language, favoritedTranslations) in favoritedTranslationsByLanguage {
        
        if favoritedTranslations.isEmpty {
            return favoritedTranslationsByLanguage
        }
        
        var newFavorites: FavoritesTranslationsStore = [:]
        newFavorites[language] = [:]
        
        dictionaryDataStore.load(language: .csUk)
        
        if let dictionary = dictionaryDataStore.dictionary {
            for (id, translation) in dictionary.phrases {
                let newHash = translation.main.translation.md5Hash()
                
                if favoritedTranslations[newHash] != nil {
                    newFavorites[language]![id] = id
                    print("Migrated favorite \(newHash) - \(id)")
                }
            }
            
            return newFavorites
        } else {
            print("Could not migrate data, failed to load dicitonary")
        }

    }
    
    return nil
}

class TranslationFavoritesService: ObservableObject {
    
    let userDefaultsStore: UserDefaultsStore
    
    /**
     A map of favorited translations by language pack and translation id
     [language pack][translationId] = translation id
    */
    @Published private(set) var favoritedTranslationsByLanguage: FavoritesTranslationsStore = [:] {
        didSet {
            userDefaultsStore.storeFavorites(favoritedTranslationsByLanguage)
        }
    }
    
    /**
    In near future we can provide interface for storing favorites, now we are using UserDefaults (we could do a wrapper that hooks on changes and sends to to backend, etc)
     */
    init (userDefaultsStore: UserDefaultsStore, dictionaryDataStore: DictionaryDataStore) {
        if let favoritesFromUserDefaults = userDefaultsStore.getFavorites() {
            
            // Migrate from md5
            if userDefaultsStore.getDataVersion() == .initial {
                if let migrated =  migrateFromInitialVersionToAirtable(favoritesFromUserDefaults, dictionaryDataStore: dictionaryDataStore) {
                    favoritedTranslationsByLanguage = migrated
                    userDefaultsStore.storeDataVersion(.airtable)
                    userDefaultsStore.storeFavorites(migrated)
                } else {
                    favoritedTranslationsByLanguage = favoritesFromUserDefaults
                }
            } else {
                favoritedTranslationsByLanguage = favoritesFromUserDefaults
            }
        }
        
        // Set as last to prevent didSet on favoritedTranslationsByLanguage
        self.userDefaultsStore = userDefaultsStore
    }
    
    func getFavorites( language: SetLanguage) -> [Dictionary.TranslationID] {
        guard let favorites = favoritedTranslationsByLanguage[language.language.main.rawValue] else {
            return []
        }
        
        // Return only ids - map not needed
        return Array(favorites.values)
    }
    
    func isFavorited(_ translation: Dictionary.Translation, language: SetLanguage) -> Bool {
        let isFavorited = favoritedTranslationsByLanguage[language.language.main.rawValue]?[translation.id]
        guard isFavorited != nil else {
            return false
        }
        
        return true
    }

    /**
     Sets favorte state by given id - will not update translation object (UI will not be updated)
     */
    func setIsFavorited(_ isFavorited: Bool, translationId: Dictionary.TranslationID, language: SetLanguage) {
        if favoritedTranslationsByLanguage[language.language.main.rawValue] == nil {
            favoritedTranslationsByLanguage[language.language.main.rawValue] = [:]
        }
        
        if isFavorited == true {
            favoritedTranslationsByLanguage[language.language.main.rawValue]![translationId] = translationId
        } else {
            favoritedTranslationsByLanguage[language.language.main.rawValue]!.removeValue(forKey:translationId)
        }
    }
}
