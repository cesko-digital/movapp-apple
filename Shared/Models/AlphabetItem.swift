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
        soundUrl: "https://data.movapp.eu/cs-alphabet/recOMNxm02MGy3r7I.mp3",
        letters: ["A", "a"],
        transcription: "[a]",
        examples: [Dictionary.Phrase.Translation(translation: "abeceda", transcription: "абецеда")]
    )

    let id: String
    let soundUrl: String?

    let letters: [String]
    let transcription: String
    let examples: [Dictionary.Phrase.Translation]

    var letter: String {
        return letters.joined(separator: " ")
    }

    var soundFileName: String? {
        guard let soundUrl = soundUrl,
              let soundUri = URL(string: soundUrl)
        else { return nil }

        let relativePath = soundUri.deletingPathExtension().relativePath.dropFirst()
        return String("\(relativePath)")
    }
}
