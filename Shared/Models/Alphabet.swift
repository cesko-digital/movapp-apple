//
//  Alphabet.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 10.04.2022.
//

import Foundation

struct Alphabet: Decodable {
    static let example = Alphabet(items: [.example], cleanItems: [.example])

    enum CodingKeys: CodingKey {
        case data, language
    }

    let items: [AlphabetItem]
    /**
        A list of AlphabetItem without diacritic
     */
    let cleanItems: [AlphabetItem]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        items = try container.decode([AlphabetItem].self, forKey: .data)

        /**
         Build items only from non-diacritic letters. Use map and an array to ensure that order is same.
         */
        var cleanItemsUniqueMap: [String: String] = [:]
        var cleanItems: [AlphabetItem] = []

        for item in items {
            guard
                let cleanLetter = item.letters
                    .first?
                    .uppercased()
                    .folding(options: .diacriticInsensitive, locale: .current)
            else {
                continue
            }

            if cleanItemsUniqueMap[cleanLetter] != nil {
                continue
            } else {
                cleanItemsUniqueMap[cleanLetter] = cleanLetter
                cleanItems.append(item)
            }
        }

        self.cleanItems = cleanItems
    }

    private init(items: [AlphabetItem], cleanItems: [AlphabetItem]) {
        self.items = items
        self.cleanItems = cleanItems
    }
}
