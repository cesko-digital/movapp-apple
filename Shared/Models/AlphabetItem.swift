//
//  AlphabetItem.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 10.04.2022.
//

import Foundation



private func buildLetter(_ letters: [String?]) -> String {
    var validLetters: [String] = []
    
    for letter in letters {
        if letter != nil {
            validLetters.append(letter!)
        }
        
    }
    
    return validLetters.joined(separator: " ")
}


struct AlphabetItem: Decodable {
    static let example = AlphabetItem(
        id: "7fc56270e7a70fa81a5935b72eacbe29",
        fileName: "7fc56270e7a70fa81a5935b72eacbe29.mp3",
        letters: ["A", "a"],
        transcription: "[a]",
        examples: [AlphabetExample(example: "abeceda", transcription: "абецеда")]
    )
    
    enum CodingKeys: CodingKey {
        case id,
             file_name,
             letter,
             transcription,
             examples
    }
    
    let id: String
    let fileName: String?
    let letter: String
    let letters: [String?] // Can contain null
    let transcription: String
    let examples: [AlphabetExample]
    
    internal init(id: String, fileName: String?, letters: [String?], transcription: String, examples: [AlphabetExample]) {
        self.id = id
        self.fileName = fileName
        self.letters = letters
        self.transcription = transcription
        self.examples = examples
        
        self.letter = buildLetter(letters)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        fileName = try container.decode(String?.self, forKey: .file_name)
        letters = try container.decode([String?].self, forKey: .letter)
        transcription = try container.decode(String.self, forKey: .transcription)
        examples = try container.decode([AlphabetExample].self, forKey: .examples)
        
        self.letter = buildLetter(letters)
        
    }
}

