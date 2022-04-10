//
//  Alphabet.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 10.04.2022.
//

import Foundation


struct Alphabet: Decodable {
    enum CodingKeys: CodingKey {
        case data, language
    }
    
    let language: String
    let data: [AlphabetItem]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        language = try container.decode(String.self, forKey: .language)
        data = try container.decode([AlphabetItem].self, forKey: .data)
    }
}


