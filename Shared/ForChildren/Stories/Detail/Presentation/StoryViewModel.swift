//
//  StoriesViewModel.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 31.10.2022.
//

import Combine
import Foundation

enum StoryState {
    case loading
    case loaded(content: StoryContent)
    case error(message: String)
}

enum PlayerButton {
    case play
    case pause
    case forward
    case backward
    case language(selected: Languages)
}

protocol StoryViewModeling: ObservableObject {
    var state: StoryState { get }
    var buttonTapped: PassthroughSubject<PlayerButton, Never> { get }

    func load()
}

class StoryViewModel: StoryViewModeling {

    @Published var state: StoryState = .loading
    let buttonTapped = PassthroughSubject<PlayerButton, Never>()

    private let metadata: StoriesSectionItem
    private let languages: SetLanguage
    private var selectedLanguage: Languages
    private let repository: StoriesRepositoring
    private var timelineMetadata: StoryMetadata?

    private var cancellables: [AnyCancellable] = []

    private var player: StoriesAudioPlayers?
    private var currentTimeTimer: Timer?

    init(metadata: StoriesSectionItem, selectedLanguage: SetLanguage, repository: StoriesRepositoring) {
        self.metadata = metadata
        self.languages = selectedLanguage
        self.selectedLanguage = selectedLanguage.languageSuffix
        self.repository = repository

        bind()
    }

    private func bind() {
        buttonTapped
            .sink { [weak self] button in
                self?.handleButton(action: button)
            }
            .store(in: &cancellables)
    }

    func load() {
        do {
            try initPlayers()
            timelineMetadata = try loadSentences()

            remake()
        } catch {
            state = .error(message: error.localizedDescription)
            return
        }
    }

    private func getLanguages() -> (selected: Languages, second: Languages) {
        let second: Languages = languages.language.main == selectedLanguage
        ? languages.language.source
        : languages.language.main
        return (selected: selectedLanguage, second: second)
    }

    private func remake() {
        state = .loaded(content:
                .init(
                    headline: .init(image: metadata.image, title: metadata.title, subtitle: metadata.subtitle),
                    player: .init(
                        timer: .init(currentTime: player?.currentTime ?? 0, maxTime: player?.duration ?? 0),
                        state: player?.isPlaying == true ? .playing : .paused,
                        languages: getLanguages()
                    ),
                    story: mateSentencesContent(timelineMetadata,
                                                selectedLanguage: selectedLanguage,
                                                currentTime: player?.currentTime ?? 0)
                )
        )
    }

    private func mateSentencesContent(
        _ timeline: StoryMetadata?,
        selectedLanguage: Languages,
        currentTime: TimeInterval
    ) -> StoryItemContent {
        guard let timeline = timeline else { fatalError() }

        let sentencesForLanguage = timeline.timeline
            .compactMap { $0.first { $0.key == selectedLanguage.rawValue } }
            .compactMap { $0.value }

        return .init(sentences: sentencesForLanguage.map {
            return .init(
                text: $0.text,
                isCurrent: currentTime >= $0.start && currentTime < $0.end,
                start: $0.start,
                end: $0.end
            )
        })
    }

    private func initPlayers() throws {
        let languages = getLanguages()
        player = try StoriesAudioPlayers(slug: metadata.slug, main: languages.selected, second: languages.second)
    }

    private func loadSentences() throws -> StoryMetadata {
       let result = repository.loadStory(slug: metadata.slug)

        switch result {
        case .success(let success):
            return success
        case .failure(let failure):
            throw failure
        }
    }

    private func handleButton(action: PlayerButton) {
        switch action {
        case .play:
            play()
        case .pause:
            pause()
        case .forward:
            player?.forward()
        case .backward:
            player?.backward()
        case .language(let selected):
            selectedLanguage = selected
            pause()
            player?.switchLanguage()
            play()
        }

        remake()
    }

    private func play() {
        player?.play()

        currentTimeTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.remake()
        }
    }

    private func pause() {
        player?.pause()

        currentTimeTimer?.invalidate()
    }
}
