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
    
    init(userDefaultsStore: UserDefaultsStore, dictionaryDataStore: DictionaryDataStore) {
        self.dictionaryDataStore = dictionaryDataStore
        self.userDefaultsStore = userDefaultsStore
        
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
                dictionaryDataStore.reload()
            }
            
            userDefaultsStore.storeLanguage(currentLanguage)
        }
        
        
    }
}
