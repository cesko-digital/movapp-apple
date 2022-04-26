//
//  LanguageService.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 26.04.2022.
//

import Foundation

final class LanguageService: ObservableObject {
    let dictionaryDataStore: DictionaryDataStore
    
    internal init(dictionaryDataStore: DictionaryDataStore) {
        self.dictionaryDataStore = dictionaryDataStore
    }
    
    @Published var currentLanguage: SetLanguage = .csUk {
        didSet {
            if currentLanguage.language.dictionaryFilePrefix != oldValue.language.dictionaryFilePrefix {
                dictionaryDataStore.reload()
            }
        }
    }
}
