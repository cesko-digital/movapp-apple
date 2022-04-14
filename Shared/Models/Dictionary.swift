//
//  Dictionary.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 07.04.2022.
//

import Foundation

struct Dictionary: Decodable {

    typealias TranslationID = String
    
    struct Section: Decodable, Identifiable {
        let id: String
        let nameFrom: String
        let nameTo: String
        let translations: [TranslationID]
        
        func text(language: SetLanguage) -> String {
            let arguments = [nameFrom , nameTo]
            return String(format: "%@ - %@", arguments: language.flipFromWithTo ? arguments.reversed() : arguments)
        }
    }
    
    struct Translation: Decodable, Identifiable {
        let id: String
        let translationFrom: String
        let transcriptionFrom: String
        let translationTo: String
        let transcriptionTo: String
    }
    
    let from: String
    let to: String
    let sections: [Section]
    let translations: [TranslationID: Translation]
}

extension Swift.Dictionary where Key == Dictionary.TranslationID, Value == Dictionary.Translation {
   
    func filter(identifiers: [Key]) -> [Value] {
        
        identifiers.reduce(into: []) { accumulator, id in
            if let translation = self[id] {
                accumulator.append(translation)
            }
        }
    }
}
