//
//  StoriesViewModel.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 31.10.2022.
//

import Foundation

struct StoryContent {

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
        let story = repository.loadStory(slug: slug)

        state = .loaded(content: .init())
    }
}
