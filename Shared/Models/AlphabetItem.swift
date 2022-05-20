//
//  AlphabetItem.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 10.04.2022.
//

import Foundation

struct AlphabetItem: Decodable {
    static let example = AlphabetItem(
        id: "7fc56270e7a70fa81a5935b72eacbe29",
        fileName: "7fc56270e7a70fa81a5935b72eacbe29.mp3",
        letters: ["A", "a"],
        transcription: "[a]",
        examples: [Dictionary.Phrase.Translation(soundUrl: nil, translation: "abeceda", transcription: "абецеда")]
    )
    
    let id: String
    let fileName: String?
    
    let letters: [String]
    let transcription: String
    let examples: [Dictionary.Phrase.Translation]
    
    var letter: String {
        return letters.joined(separator: " ")
    }
}

