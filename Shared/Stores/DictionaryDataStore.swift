//
//  DictionaryDataStore.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 07.04.2022.
//

import SwiftUI

class DictionaryDataStore: ObservableObject {

    static var shared: DictionaryDataStore = DictionaryDataStore()

    @Published var loading: Bool = false
    var dictionary: Dictionary?
    var error: String?

    func reset () {
        dictionary = nil
        error = nil
        loading = false // Force reload data
    }

    func load(language: SetLanguage) {
        if loading {
            return
        }

        loading = true

        do {
            let loadedDictionary = try DictionaryRepository().load(language: language)

            let visibleCategories = loadedDictionary.categories.filter {
                $0.isMetaCategory == false
            }
            self.dictionary = Dictionary(main: loadedDictionary.main,
                                         source: loadedDictionary.source,
                                         categories: visibleCategories,
                                         phrases: loadedDictionary.phrases)

        } catch {
            self.error = error.localizedDescription
            print("Failed to load data", error)
        }

        loading = false
    }
}
