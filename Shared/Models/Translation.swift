//
//  Translation.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import Foundation


struct Translation: Decodable, Identifiable {
    let id: String
    // TODO rename to more universal, language will have own json
    let translation_from: String
    let transcription_from: String
    
    let translation_to: String
    let transcription_to: String
    
    // TODO rename
    let sectionIds: [String]
}


struct Translations: Decodable {
    
    // Define typealias required for Collection protocl conformance
    typealias TranslationsList = [String: Translation]
    
    
    // Define DynamicCodingKeys type needed for creating decoding container from JSONDecoder
    private struct DynamicCodingKeys: CodingKey {
        
        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }
    
    let byId: TranslationsList
    
    init (byId: TranslationsList) {
        self.byId = byId
    }
    
    init(from decoder: Decoder) throws {
        
        // Create decoding container using DynamicCodingKeys
        // The container will contain all the JSON first level key
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        // ***
        var temp = TranslationsList()
        
        // Loop through each keys in container
        for key in container.allKeys {
            
            // Decode Student using key & keep decoded Student object in tempArray
            let decodedObject = try container.decode(Translation.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            
            temp[key.stringValue] = decodedObject
        }
        
        // Finish decoding all Student objects. Thus assign tempArray to array.
        byId = temp
    }
}

#if DEBUG
let exampleTranslation = Translation(
    id: "f22b3b19f76d8857a3171412fb5f35fc",
    translation_from: "Dobrý den.",
    transcription_from: "Dobryj deň",
    translation_to: "Добри ден",
    transcription_to: "Добрий день.",
    sectionIds: ["d6e710c7f44b67220cd9b870e6107bf9"]
)
#endif
