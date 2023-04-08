//
//  StoryMetadata.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 27.10.2022.
//

import Foundation

struct StoryMetadata: Decodable {
    let timeline: [[String: StoryDetailEntry]]
}

struct StoryDetailEntry: Decodable {
    let text: String
    let start: Double
    let end: Double
}

struct StoriesMetadata: Decodable {
    let stories: [Story]
}

struct Story: Decodable {
    let title: [String: String]
    let slug: String
    let duration: String
    let origin: String
    let supportedLanguages: [String]
}
