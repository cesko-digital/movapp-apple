//
//  StoryMetadata.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 27.10.2022.
//

import Foundation

struct StoryMetadata: Decodable {
    let title: [String: String]
    let slug: String
    let duration: Int
    let origin: String
    let supportedLanguages: [String]
}
