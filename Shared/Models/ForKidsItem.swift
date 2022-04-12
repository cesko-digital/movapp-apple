//
//  ForKids.swift
//  Movapp (iOS)
//
//  Created by Daryna Polevyk on 11.04.2022.
//

import Foundation

struct ForKidsItem: Identifiable, Decodable {
    var id = UUID()
    
#if DEBUG
    static let example = ForKidsItem(
        czTranslation: "panenka",
        czTranscription: "паненка",
        uaTranslation: "лялька",
        uaTranscription: "ljal’ka",
        imageName: "panenka"
    )
#endif

    let czTranslation, czTranscription, uaTranslation, uaTranscription: String
    let imageName: String

    enum CodingKeys: String, CodingKey {
        case czTranslation = "cz_translation"
        case czTranscription = "cz_transcription"
        case uaTranslation = "ua_translation"
        case uaTranscription = "ua_transcription"
        case imageName
    }
    
    internal init(czTranslation: String, czTranscription: String, uaTranslation: String, uaTranscription: String, imageName: String) {
        self.czTranslation = czTranslation
        self.czTranscription = czTranscription
        self.uaTranslation = uaTranslation
        self.uaTranscription = uaTranscription
        self.imageName = imageName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        czTranslation = try container.decode(String.self, forKey: .czTranslation)
        czTranscription = try container.decode(String.self, forKey: .czTranscription)
        uaTranslation = try container.decode(String.self, forKey: .uaTranslation)
        uaTranscription = try container.decode(String.self, forKey: .uaTranscription)
        imageName = try container.decode(String.self, forKey: .imageName)
    }
}

