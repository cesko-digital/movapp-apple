//
//  Team.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.05.2022.
//

import Foundation

struct Team: Decodable {
    let sections: [Section]
}

extension Team {
    struct Section: Decodable, Identifiable {
        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case name, members
        }

        var id = UUID()
        let name: [String: String]
        let members: [Member]
    }
}

extension Team.Section {
    struct Member: Decodable, Identifiable {
        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case name

        }

        var id = UUID()
        let name: String
    }
}
