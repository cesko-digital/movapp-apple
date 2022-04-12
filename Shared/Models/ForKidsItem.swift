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
        translationFrom: "panenka",
        transcriptionFrom: "паненка",
        translationTo: "лялька",
        transcriptionTo: "ljal’ka",
        imageName: "panenka"
    )
#endif

    let translationFrom, transcriptionFrom, translationTo, transcriptionTo: String
    let imageName: String

    enum CodingKeys: String, CodingKey {
        case translationFrom = "cz_translation"
        case transcriptionFrom = "cz_transcription"
        case translationTo = "ua_translation"
        case transcriptionTo = "ua_transcription"
        case imageName = "image"
    }
    
    internal init(translationFrom: String, transcriptionFrom: String, translationTo: String, transcriptionTo: String, imageName: String) {
        self.translationFrom = translationFrom
        self.transcriptionFrom = transcriptionFrom
        self.translationTo = translationTo
        self.transcriptionTo = transcriptionTo
        self.imageName = imageName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        translationFrom = try container.decode(String.self, forKey: .translationFrom)
        transcriptionFrom = try container.decode(String.self, forKey: .transcriptionFrom)
        translationTo = try container.decode(String.self, forKey: .translationTo)
        transcriptionTo = try container.decode(String.self, forKey: .transcriptionTo)
        imageName = try container.decode(String.self, forKey: .imageName)
    }
}

