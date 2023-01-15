//
//  PexesoRepository.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 17.10.2022.
//

import Foundation

class PexesoRepository {

    private var dataStore: DictionaryDataStore

    init(dataStore: DictionaryDataStore) {
        self.dataStore = dataStore
    }

    func load() -> [Dictionary.Phrase]? {
        guard let dictionary = dataStore.dictionary,
              let childrenCategory = dictionary.categories.first(where: { $0.id == "recSHyEn6N0hAqUBp" }) else {
            return nil
        }

        return dictionary.phrases.filter(identifiers: childrenCategory.phrases).filter { $0.imageUrl != nil }
    }
}
