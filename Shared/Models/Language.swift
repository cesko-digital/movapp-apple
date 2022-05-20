//
//  Language.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.04.2022.
//

import Foundation

struct Language {
    /**
     Indicates which file should be loaded
     */
    var dictionaryFilePrefix: String {
        return "\(source.rawValue)-\(main.rawValue)"
    }
    
    /**
     Language code - defines a language used in `from` key in our data files
     */
    let main: Languages
    
    /**
     Language code - defines a language used in `to` key in our data files
     */
    let source: Languages

}




