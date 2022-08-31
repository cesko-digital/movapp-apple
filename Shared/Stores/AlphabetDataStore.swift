//
//  AlphabetDataStore.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 10.04.2022.
//

import SwiftUI

class AlphabetDataStore {

    func load(with language: SetLanguage, alphabet: Languages) throws -> Alphabet  {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        // Always build the opposite
        let to = language.language.source == alphabet ? language.language.main : language.language.source

        let fileName = "data/\(alphabet)-\(to)-alphabet"
        guard let asset = NSDataAsset(name:  fileName) else {
            throw MissingAssetError("Invalid data file name")
        }

        let data = asset.data

        return try decoder.decode(Alphabet.self, from: data)
    }
}

struct MissingAssetError: Error {

    let message: String

    init(_ message: String) {
        self.message = message
    }
}
