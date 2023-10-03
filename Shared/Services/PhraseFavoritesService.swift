//
//  FavoritesService.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 05.04.2022.
//

import Foundation

private func migrateFromInitialVersionToAirtable(
    _ favoritedPhrasesByLanguage: FavoritesPhrasesStore,
    dictionaryDataStore: DictionaryDataStore
) -> FavoritesPhrasesStore? {

    if favoritedPhrasesByLanguage.isEmpty {
        return nil
    }

    // Initial version had only one language -- CS
    for (language, favoritedPhrases) in favoritedPhrasesByLanguage {

        if favoritedPhrases.isEmpty {
            return favoritedPhrasesByLanguage
        }

        var newFavorites: FavoritesPhrasesStore = [:]
        newFavorites[language] = [:]

        dictionaryDataStore.load(language: .csUk)

        if let dictionary = dictionaryDataStore.dictionary {
            for (id, translation) in dictionary.phrases {
                let newHash = translation.main.translation.md5Hash()

                if favoritedPhrases[newHash] != nil {
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

class PhraseFavoritesService: ObservableObject {

    let userDefaultsStore: UserDefaultsStore

    /**
     A map of favorited phases by language pack and phrase id
     [language pack][translationId] = phrase id
    */
    @Published private(set) var favoritedPhrasesByLanguage: FavoritesPhrasesStore = [:] {
        didSet {
            userDefaultsStore.storeFavorites(favoritedPhrasesByLanguage)
        }
    }

    /**
     In near future we can provide interface for storing favorites,
     now we are using UserDefaults (we could do a wrapper that hooks on changes and sends to to backend, etc)
     */
    init (userDefaultsStore: UserDefaultsStore, dictionaryDataStore: DictionaryDataStore) {
        if let favoritesFromUserDefaults = userDefaultsStore.getFavorites() {

            // Migrate from md5
            if userDefaultsStore.getDataVersion() == .initial {
                if let migrated = migrateFromInitialVersionToAirtable(favoritesFromUserDefaults,
                                                                      dictionaryDataStore: dictionaryDataStore) {
                    favoritedPhrasesByLanguage = migrated
                    userDefaultsStore.storeDataVersion(.airtable)
                    userDefaultsStore.storeFavorites(migrated)
                } else {
                    favoritedPhrasesByLanguage = favoritesFromUserDefaults
                }
            } else {
                favoritedPhrasesByLanguage = favoritesFromUserDefaults
            }
        }

        // Set as last to prevent didSet on favoritedPhrasesByLanguage
        self.userDefaultsStore = userDefaultsStore
    }

    func getFavorites( language: SetLanguage) -> [Dictionary.PhraseID] {
        guard let favorites = favoritedPhrasesByLanguage[language.language.main.rawValue] else {
            return []
        }

        // Return only ids - map not needed
        return Array(favorites.values)
    }

    func isFavorited(_ phrase: Dictionary.Phrase, language: SetLanguage) -> Bool {
        let isFavorited = favoritedPhrasesByLanguage[language.language.main.rawValue]?[phrase.id]
        guard isFavorited != nil else {
            return false
        }

        return true
    }

    /**
     Sets favorte state by given id - will not update phrase object (UI will not be updated)
     */
    func setIsFavorited(_ isFavorited: Bool, translationId: Dictionary.PhraseID, language: SetLanguage) {
        if favoritedPhrasesByLanguage[language.language.main.rawValue] == nil {
            favoritedPhrasesByLanguage[language.language.main.rawValue] = [:]
        }

        if isFavorited == true {
            favoritedPhrasesByLanguage[language.language.main.rawValue]![translationId] = translationId
        } else {
            favoritedPhrasesByLanguage[language.language.main.rawValue]!.removeValue(forKey: translationId)
        }
    }
}
