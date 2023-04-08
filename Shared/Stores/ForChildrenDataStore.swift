//
//  ForChildrenDataStore.swift
//  Movapp (iOS)
//
//  Created by Daryna Polevyk on 11.04.2022.
//

import SwiftUI

class ForChildrenDataStore: ObservableObject {
    let dictionaryDataStore: DictionaryDataStore

    init(dictionaryDataStore: DictionaryDataStore) {
        self.dictionaryDataStore = dictionaryDataStore
    }

    @Published var loading: Bool = false

    var forChildren: [Dictionary.Phrase]?
    var error: String?

    func reset() {
        forChildren = nil
        error = nil
        loading = false
    }

    func load() {
        if loading {
            return
        }

        loading = true

        if let dictionary = dictionaryDataStore.dictionary {

            if let childrenCategory = dictionary.categories.first(where: { $0.id == "recSHyEn6N0hAqUBp" }) {
                self.forChildren = dictionary.phrases.filter(identifiers: childrenCategory.phrases)
            } else {
               error = "Could not find the for kids in data source"
               print(error!)
           }

        } else {
            error = "Dictionary not loaded"
            print(error!)
        }

        loading = false
    }
}
