//
//  Languages.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import Foundation


// TODO try to design something more easier to use
enum Language: String, CaseIterable, Identifiable {
    
    // At this moment this is in view
    case csUk = "CZ->UK"
    case ukCs = "UK->CZ"
    
    var id: Self { self }
    
    var speachLanguage: String {
        get {
            switch(self) {
            case .csUk:
                return "cs"
            case .ukCs:
                return "uk"
            }
        }
    }
    
    
    /**
     Indicates which file should be loaded (files are stored in assets with translations-{prefix}, sections-{prefix} name)
     */
    var filePrefix: String {
        get {
            switch(self) {
            case .csUk, .ukCs:
                return "cs"
            }
        }
    }
    
    /**
     Indicates if we should swap X_from with X_to (reuses same data file)
     */
    var flipFromWithTo: Bool {
        get {
            switch(self) {
            case .ukCs:
                return true
            case .csUk:
                return false
            }
        }
    }
}
