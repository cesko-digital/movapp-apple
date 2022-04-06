//
//  Translation.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import Foundation


/*
 Due the translation favorite system and lazy grid we need to return different state
 when SwiftUI is comparing if the data of the object has changed
 */
class Translation: Decodable, Identifiable, ObservableObject {
    let id: String
    // TODO rename to more universal, language will have own json
    let translationFrom: String
    let transcriptionFrom: String
    
    let translationTo: String
    let transcriptionTo: String
    
    @Published var isFavorited: Bool = false
    
    enum CodingKeys: CodingKey {
        case id, translation_from, transcription_from, translation_to, transcription_to
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        translationFrom = try container.decode(String.self, forKey: .translation_from)
        transcriptionFrom = try container.decode(String.self, forKey: .transcription_from)
        translationTo = try container.decode(String.self, forKey: .translation_to)
        transcriptionTo = try container.decode(String.self, forKey: .transcription_to)
    }
    
    internal init(id: String, translation_from: String, transcription_from: String, translation_to: String, transcription_to: String) {
        self.id = id
        self.translationFrom = translation_from
        self.transcriptionFrom = transcription_from
        self.translationTo = translation_to
        self.transcriptionTo = transcription_to
    }
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
            
            do {
                // Decode Student using key & keep decoded Student object in tempArray
                let decodedObject = try container.decode(Translation.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
                
                temp[key.stringValue] = decodedObject
            } catch {
                print("Failed to decode translation data \(error)")
            }
        }
        
        // Finish decoding all Student objects. Thus assign tempArray to array.
        byId = temp
    }
}

let exampleTranslation = Translation(
    id: "f22b3b19f76d8857a3171412fb5f35fc",
    translation_from: "Dobrý den.",
    transcription_from: "Dobryj deň",
    translation_to: "Добри ден",
    transcription_to: "Добрий день."
)
