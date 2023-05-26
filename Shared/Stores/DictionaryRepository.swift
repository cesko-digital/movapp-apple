//
//  DictionaryRepository.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 26.05.2023.
//

import SwiftUI

protocol DictionaryRepositoryType {
    func load(language: SetLanguage) throws -> Dictionary
}

final class DictionaryRepository: DictionaryRepositoryType {
    func load(language: SetLanguage) throws -> Dictionary {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let prefix = language.language.dictionaryFilePrefix

        guard let asset = NSDataAsset(name: "\(prefix)-dictionary") else {
            throw MissingAssetError("Invalid data file name")
        }

        let loadedDictionary = try decoder.decode(Dictionary.self, from: asset.data)
        let visibleCategories = loadedDictionary.categories.filter {
            $0.isHidden == false
        }
        return Dictionary(main: loadedDictionary.main,
                          source: loadedDictionary.source,
                          categories: visibleCategories,
                          phrases: loadedDictionary.phrases)
    }
}
