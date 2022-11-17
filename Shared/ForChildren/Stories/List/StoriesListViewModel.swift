//
//  StoriesListViewModel.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 12.11.2022.
//

import Combine
import Foundation

extension StoriesSectionItem {
    static func mock() -> StoriesSectionItem {
        StoriesSectionItem(title: "O perníkové chaloupce",
                           subtitle: "Прянична хатинка",
                           image: "data/stories/cervena-karkulka/thumbnail",
                           duration: "3 min",
                           slug: "pernikova-chaloupka")
    }
}

struct StoriesSectionItem: Identifiable, Hashable {
    var id: UUID { UUID() }

    let title: String
    let subtitle: String
    let image: String
    let duration: String
    let slug: String
}

struct StoriesSection: Identifiable {
    var id: UUID { UUID() }

    let title: String
    let stories: [StoriesSectionItem]
}

enum StoriesState {
    case loading
    case loaded(content: [StoriesSection])
    case error(message: String)
}

protocol StoriesListViewModeling: ObservableObject {
    var state: StoriesState { get }
    var viewAppeared: PassthroughSubject<Void, Never> { get }
}

class StoriesListViewModel: StoriesListViewModeling {

    @Published var state: StoriesState = .loading
    let viewAppeared = PassthroughSubject<Void, Never>()

    private var cancellables: [AnyCancellable] = []
    private let storiesRepository = StoriesRepository()
    private let selectedLanguage: SetLanguage

    init(selectedLanguage: SetLanguage) {
        self.selectedLanguage = selectedLanguage

        bind()
    }

    func bind() {
        viewAppeared
            .sink { [weak self] in
                self?.load()
            }
            .store(in: &cancellables)
    }

    private func load() {
        let result = storiesRepository.loadStories()

        switch result {
        case .success(let success):
            loaded(storyMetadata: success)
        case .failure(let failure):
            state = .error(message: failure.localizedDescription)
        }
    }

    private func loaded(storyMetadata: StoriesMetadata) {
        let firstLanguage = selectedLanguage.languagePrefix
        let secondLanguage = selectedLanguage.languageSuffix

        let storiesSorted = storyMetadata.stories
            .filter {
                $0.supportedLanguages.contains(firstLanguage.rawValue)
                || $0.supportedLanguages.contains(secondLanguage.rawValue)
            }
            .sorted { $0.origin < $1.origin }
        let countryGroupedStories: [String: [Story]] = .init(grouping: storiesSorted,
                                                             by: { $0.origin })
        state = .loaded(content: countryGroupedStories
            .sorted(by: { $0.key < $1.key })
            .map {
                StoriesSection(title: $0.key,
                               stories: $0.value.map {
                    StoriesSectionItem(title: $0.title[firstLanguage.rawValue] ?? "",
                                       subtitle: $0.title[secondLanguage.rawValue] ?? "",
                                       image: "data/stories/\($0.slug)/thumbnail",
                                       duration: "\($0.duration) min",
                                       slug: $0.slug)
                })
            })
    }
}
