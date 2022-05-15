//
//  AlphabetDataStore.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 10.04.2022.
//

import SwiftUI

class AlphabetDataStore: ObservableObject {
    
   // TODO load all at once? Cache?
    
    @Published var loading: Bool = false
    
    var alphabet: Alphabet?
    var error: String? // TODO enum?
    
    func reset () {
        alphabet = nil
        error = nil
        loading = false
    }
    
    func load(language: SetLanguage)  {
        
        if loading {
            return
        }
        
        loading = true
        
        let decoder = JSONDecoder()
        
        let prefix = language.flipFromWithTo ? language.language.source : language.language.main
        
        do {
            guard let asset = NSDataAsset(name:  "data/\(prefix)-alphabet") else {
                error = "Invalid data file name"
                loading = false
                return
            }
            
            let data = asset.data
            
            self.alphabet = try decoder.decode(Alphabet.self, from: data)
            
        } catch {
            self.error = error.localizedDescription
        }
        
        loading = false
    }
}

