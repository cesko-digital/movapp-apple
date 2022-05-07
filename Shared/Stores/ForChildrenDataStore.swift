//
//  ForChildrenDataStore.swift
//  Movapp (iOS)
//
//  Created by Daryna Polevyk on 11.04.2022.
//


import SwiftUI

class ForChildrenDataStore: ObservableObject {
    
    @Published var loading: Bool = false
    
    var forKids: [ForChildrenItem]?
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

            self.forKids = try decoder.decode([ForChildrenItem].self, from: data)
            
        } catch {
            self.error = error.localizedDescription
        }
        
        loading = false
    }
}
