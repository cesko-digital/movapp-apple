//
//  ForChildrenRootViewModel.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 27.10.2022.
//

import Foundation

struct ForChildrenRootStoriesSectionItem: Identifiable {
    var id: UUID { UUID() }

    let title: String
    let image: String
    let duration: String
}

struct ForChildrenRootStoriesSection: Identifiable {
    var id: UUID { UUID() }

    let title: String
    let stories: [ForChildrenRootStoriesSectionItem]
}

enum ForChildrenRootState {
    case loading
    case imagesOnly
    case imagesWithStories(content: [ForChildrenRootStoriesSection])
}

protocol ForChildrenRootViewModeling: ObservableObject {
    var state: ForChildrenRootState { get }

    func load()
}

class ForChildrenRootViewModel: ForChildrenRootViewModeling {

    @Published var state: ForChildrenRootState

    private let storiesRepository: StoriesRepository

    init(selectedLanguage: SetLanguage, storiesRepository: StoriesRepository) {
        self.storiesRepository = storiesRepository

        if selectedLanguage == .csUk || selectedLanguage == .ukCs {
            state = .loading
        } else {
            state = .imagesOnly
        }
    }

    func load() {
        guard
            case .loading = state,
            let stories = storiesRepository.loadStories(),
            !stories.isEmpty
        else {
            state = .imagesOnly
            return
        }

        let countryGroupedStories: [String: [StoryMetadata]] = .init(grouping: stories, by: { $0.origin })

        state = .imagesWithStories(content:
                                    countryGroupedStories.map {
            ForChildrenRootStoriesSection(title: $0.key,
                                          stories: $0.value.map {
                ForChildrenRootStoriesSectionItem(title: $0.title["cs"] ?? "",
                                                  image: "\($0.slug)/thumbnail",
                                                  duration: "\($0.duration)")
            })
        })
    }
}
