//
//  ForKidsDataStore.swift
//  Movapp (iOS)
//
//  Created by Daryna Polevyk on 11.04.2022.
//

import Foundation
import UIKit

class ForKidsDataStore: ObservableObject {
    
    @Published var loading: Bool = false
    
    var forKids: [ForKidsItem]?
    var error: String? // TODO enum?
    
    func reset() {
        forKids = nil
        error = nil
        loading = false
    }
    
    func load() {
        if loading {
            return
        }
        
        loading = true
        
        let decoder = JSONDecoder()
        do {
            guard let asset = NSDataAsset(name: "data/pro-deti") else {
                error = "Invalid data file name"
                loading = false
                return
            }
            
            let data = asset.data
            print(data)
            self.forKids = try decoder.decode([ForKidsItem].self, from: data)
            
        } catch {
            self.error = error.localizedDescription
        }
        
        loading = false
    }
}
