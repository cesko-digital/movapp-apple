//
//  UserDefaultsStore.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 27.04.2022.
//

import Foundation

typealias FavoritesPhrasesStore = [String: [String: String]]

enum DataVersion: Int {
    case initial = 0
    case airtable = 1
}

struct UserDefaultsStore {

    private let onBoardingCompleteKey = "onboarding.complete"
    private let favoritesKey = "favorite.translations"
    private let favoritesVersionKey = "favorite.translations.version"
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

    func storeFavorites(_ favoritedPhrasesByLanguage: FavoritesPhrasesStore) {
        userDefaults.setValue(favoritedPhrasesByLanguage, forKey: favoritesKey)
    }

    func getFavorites () -> FavoritesPhrasesStore? {
        return userDefaults.object(forKey: favoritesKey) as? FavoritesPhrasesStore
    }

    func storeDataVersion(_ version: DataVersion) {
        userDefaults.setValue(version.rawValue, forKey: favoritesVersionKey)
    }

    func getDataVersion () -> DataVersion {
        // 0 - First initial version of phrase keys -> md5
        // 1 - New keys from AirTable
        if let version =  DataVersion.init(rawValue: userDefaults.integer(forKey: favoritesVersionKey)) {
            return version
        }

        return DataVersion.initial
    }
}
