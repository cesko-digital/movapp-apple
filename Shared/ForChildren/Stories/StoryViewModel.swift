//
//  StoriesViewModel.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 31.10.2022.
//

import Foundation

enum PlayerState {
    case none
    case playing
    case paused
}

struct PlayerContent {
    let timer: PlayerTimer
    let state: PlayerState
}

struct PlayerTimer {
    let currentTime: Double
    let maxTime: Double
}

struct SentenceContent {
    let text: String
    let isCurrent: Bool
    let start: Double
    let end: Double
}

struct StoryItemContent {
    let sentences: [SentenceContent]
}

struct StoryContent {
    let player: PlayerContent
    // let firstLanguage: StoryItemContent
    // let secondLanguage: StoryItemContent
}

enum StoryState {
    case loading
    case loaded(content: StoryContent)
}

protocol StoryViewModeling: ObservableObject {
    var state: StoryState { get }

    func load()
}

class StoryViewModel: StoryViewModeling {

    @Published var state: StoryState = .loading

    private let slug: String
    private let selectedLanguage: SetLanguage
    private let repository: StoriesRepository

    init(slug: String, selectedLanguage: SetLanguage) {
        self.slug = slug
        self.selectedLanguage = selectedLanguage
        repository = StoriesRepository()
    }

    func load() {
        let result = repository.loadStory(slug: slug)

        guard case .success(let story) = result else {
            return
        }

        // TODO: transform data to reload
        state = .loaded(content: .init(player: .init(timer: .init(currentTime: 0, maxTime: 0), state: .none)))
    }
}
