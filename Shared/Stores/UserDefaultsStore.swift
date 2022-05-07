//
//  UserDefaultsStore.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 27.04.2022.
//

import Foundation

typealias FavoritesTranslationsStore = [String: [String: String]]

struct UserDefaultsStore {
    
    private let onBoardingCompleteKey = "onboarding.complete"
    private let favoritesKey = "favorite.translations"
    private let languageKey = "language"
    
    let userDefaults: UserDefaults
    
    init () {
        userDefaults = UserDefaults(suiteName: "group.cz.movapp.app")!
    }
    
    func getOnBoardingComplete() -> Bool {
        return userDefaults.bool(forKey: onBoardingCompleteKey)
    }
    
    func storeOnBoardingComplete(_ value: Bool = true) {
        print("Storing onboarding completion \(value)")
        userDefaults.set(value, forKey: onBoardingCompleteKey)
    }
    
    func getLanguage() -> SetLanguage? {
        if let language =  userDefaults.string(forKey: languageKey) {
            print("Stored language \(language)")
            for setLanguage in SetLanguage.allCases {
                if setLanguage.id == language {
                    return setLanguage
                }
            }
        }
        
        return nil
    }
    
    func storeLanguage(_ language: SetLanguage) {
        print("Storing language \(language)")
        userDefaults.set(language.id, forKey: languageKey)
    }
    
    func storeFavorites(_ favoritedTranslationsByLanguage: FavoritesTranslationsStore) {
        userDefaults.setValue(favoritedTranslationsByLanguage, forKey: favoritesKey)
    }
    
    func getFavorites () -> FavoritesTranslationsStore? {
        return userDefaults.object(forKey: favoritesKey) as? FavoritesTranslationsStore
    }
}


