//
//  Dictionary.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 07.04.2022.
//

import Foundation


struct Dictionary: Decodable {
    enum CodingKeys: CodingKey {
        case sections, translations
    }
    
    let translations: Translations
    let sections: Sections
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        sections = try container.decode([Section].self, forKey: .sections)
        translations = try container.decode(Translations.self, forKey: .translations)
    }
}

