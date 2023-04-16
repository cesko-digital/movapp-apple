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
        guard let dictionary = dataStore.dictionary else {
            return nil
        }

        return dictionary.phrases.values.filter { $0.imageUrl != nil }
    }
}
