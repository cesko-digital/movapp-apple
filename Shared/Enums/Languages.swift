//
//  Languages.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 12.04.2022.
//

import Foundation

enum Languages: String {
    case cs = "cs"
    case uk = "uk"
    case pl = "pl"
    case sk = "sk"

    var flag: Flags {
        switch(self) {
        case .cs:
            return Flags.cs
        case .uk:
            return Flags.uk
        case .pl:
            return Flags.pl
        case .sk:
            return Flags.sk
        }
    }

    var title: String {
        switch self {
        case .cs: return "czech"
        case .uk: return "ukrainian"
        case .pl: return "polish"
        case .sk: return "slovakia"
        }
    }

    var alphabetTitle: String {
        return String("alphabet_\(self.rawValue)")
    }

    static let allCases: [Languages] = [.uk, .sk, .cs, .pl]
}
