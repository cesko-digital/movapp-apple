//
//  DictionaryDataStore.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 07.04.2022.
//

import Foundation
import UIKit

class DictionaryDataStore: ObservableObject {
    
    @Published var dictionary: Dictionary?
    @Published var error: String? // TODO enum?
    
    func reset () {
        dictionary = nil
    }
    
    func load(language: SetLanguage, favoritesService: TranslationFavoritesService)  {
        let decoder = JSONDecoder()
        
        let prefix = language.language.dictionaryFilePrefix
        
        do {
            guard let asset = NSDataAsset(name:  "data/\(prefix)-dictionary") else {
                error = "Invalid data file name"
                return
            }
            
            let data = asset.data
            
            let dictionary = try decoder.decode(Dictionary.self, from: data)
            //self.error = nil
            
            let favoriteIds = favoritesService.getFavorites(language: language)
            
            for translationId in favoriteIds {
                guard let translation = dictionary.translations.byId[translationId] else {
                    print("Favorite list has non-existing translation")
                    favoritesService.setIsFavorited(false, translationId: translationId, language: language)
                    continue
                }
                
                translation.isFavorited = true
                
            }
            
            
            self.dictionary = dictionary
            
        } catch {
            self.error = error.localizedDescription
        }
    }
}
