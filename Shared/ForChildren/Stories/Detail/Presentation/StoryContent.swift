//
//  StoryContent.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 21.11.2022.
//

enum PlayerState {
    case none
    case playing
    case paused
}

struct PlayerContent {
    let timer: PlayerTimer
    let state: PlayerState
    let languages: (selected: Languages, second: Languages)
}

struct PlayerTimer {
    let currentTime: Double
    let maxTime: Double
}

struct SentenceContent: Hashable {
    let text: String
    let isCurrent: Bool
    let start: Double
    let end: Double
}

struct StoryItemContent: Equatable {
    let sentences: [SentenceContent]
}

struct StoryHeadline {
    let image: String
    let title: String
    let subtitle: String
}

struct StoryContent {
    let headline: StoryHeadline
    let player: PlayerContent
    let story: StoryItemContent
}
