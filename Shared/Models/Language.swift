//
//  Language.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.04.2022.
//

import Foundation

struct Language {
    /**
     Indicates which file should be loaded (files are stored in assets with translations-{prefix}, sections-{prefix} name)
     */
    var dictionaryFilePrefix: String {
        return "\(from.rawValue)-\(to.rawValue)"
    }
    
    /**
     Language code - defines a language used in `from` key in our data files
     */
    let from: Languages
    
    /**
     Language code - defines a language used in `to` key in our data files
     */
    let to: Languages
}




