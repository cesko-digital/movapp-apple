//
//  AlphabetExample.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 10.04.2022.
//

import Foundation


struct AlphabetExample: Decodable {
    
    enum CodingKeys: CodingKey {
        case example,
             example_transcription
    }
    
    let example: String
    let transcription: String
   
    internal init(example: String, transcription: String) {
        self.example = example
        self.transcription = transcription
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        example = try container.decode(String.self, forKey: .example)
        transcription = try container.decode(String.self, forKey: .example_transcription)
    }
}
