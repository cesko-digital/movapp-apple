//
//  Dictionary.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 07.04.2022.
//

import Foundation

struct Dictionary: Decodable {

    typealias TranslationID = String
    
    struct Category: Decodable, Identifiable {
        struct Name: Decodable {
            let source: String
            let main: String
        }
        
        let id: String
        let name: Name
        let phrases: [TranslationID]
        
        func text(language: SetLanguage) -> String {
            let arguments = [name.main , name.source]
            return String(format: "%@ - %@", arguments: language.flipFromWithTo ? arguments.reversed() : arguments)
        }
    }
    
    struct Phrase: Decodable, Identifiable {
        
        struct Translation: Decodable {
            let soundUrl: String?
            let translation: String
            let transcription: String
            
            var soundFileName: String?  {
                if soundUrl == nil {
                    return nil
                }
                
                return translation.md5Hash()
            }
        }
        
        let id: String
        let source: Translation
        let main: Translation
        let imageUrl: String?
        
        var imageName: String? {
            if imageUrl == nil {
                return nil
            }
            
            return "images/\(id)"
        }
    }
    
    let main: String
    let source: String
    let categories: [Category]
    let phrases: [TranslationID: Phrase]
}

extension Swift.Dictionary where Key == Dictionary.TranslationID, Value == Dictionary.Phrase {
   
    func filter(identifiers: [Key]) -> [Value] {
        
        identifiers.reduce(into: []) { accumulator, id in
            if let translation = self[id] {
                accumulator.append(translation)
            }
        }
    }
}
