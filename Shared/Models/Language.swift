//
//  Language.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.04.2022.
//

import Foundation

struct Language {
    static let cs = "cs"
    static let uk = "uk"
    
    /**
     Indicates which file should be loaded (files are stored in assets with translations-{prefix}, sections-{prefix} name)
     */
    let filePrefix: String
    
    /**
     Language code - defines a language used in `from` key in our data files
     */
    let from: String
    
    /**
     Language code - defines a language used in `to` key in our data files
     */
    let to: String
}




