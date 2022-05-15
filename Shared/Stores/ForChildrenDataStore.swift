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
    
    var forChildren: [Dictionary.Translation]?
    var error: String? // TODO enum?
    
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
            
            for category in dictionary.categories {
                
                if category.id == "recSHyEn6N0hAqUBp" {
                    self.forChildren = dictionary.phrases.filter(identifiers: category.phrases)
                    break;
                }
            }
            
            if forChildren == nil {
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
