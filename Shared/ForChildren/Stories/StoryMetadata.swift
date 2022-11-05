//
//  StoryMetadata.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 27.10.2022.
//

import Foundation

struct StoryMetadata: Decodable {
    let timeline: [StoryDetail]
}

struct StoryDetail: Decodable {
    let cs: StoryDetailEntry
    let uk: StoryDetailEntry
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
    let duration: Int
    let origin: String
    let supportedLanguages: [String]
}
