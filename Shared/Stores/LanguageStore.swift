//
//  LanguageStore.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 26.04.2022.
//

import Foundation

final class LanguageStore: ObservableObject {
    
    let userDefaultsStore: UserDefaultsStore
    let dictionaryDataStore: DictionaryDataStore
    let forChildrenDataStore: ForChildrenDataStore
    
    init(userDefaultsStore: UserDefaultsStore, dictionaryDataStore: DictionaryDataStore, forChildrenDataStore: ForChildrenDataStore) {
        self.dictionaryDataStore = dictionaryDataStore
        self.userDefaultsStore = userDefaultsStore
        self.forChildrenDataStore = forChildrenDataStore
        
        if let language = userDefaultsStore.getLanguage() {
            currentLanguage = language
            
            print("Setting language \(language)")
        } else {
            currentLanguage = Locale.current.languageCode == "uk" ? .ukCs : .csUk
        }
    }
    
    @Published var currentLanguage: SetLanguage {
        didSet {
            if currentLanguage.language.dictionaryFilePrefix != oldValue.language.dictionaryFilePrefix {
                dictionaryDataStore.reset()
                forChildrenDataStore.reset()
            }
            
            userDefaultsStore.storeLanguage(currentLanguage)
        }
    }
}
