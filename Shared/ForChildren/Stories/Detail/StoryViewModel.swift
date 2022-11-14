//
//  StoriesViewModel.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 31.10.2022.
//

import AVFoundation
import Combine
import Foundation
import UIKit

enum PlayerState {
    case none
    case playing
    case paused
}

struct PlayerContent {
    let timer: PlayerTimer
    let state: PlayerState
    let languages: [Languages]
    let selectedLanguage: Languages
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

struct StoryHeadline {
    let image: String
    let title: String
    let subtitle: String
}

struct StoryContent {
    let headline: StoryHeadline
    let player: PlayerContent
    // let firstLanguage: StoryItemContent
    // let secondLanguage: StoryItemContent
}

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
    private let selectedLanguage: SetLanguage
    private let repository: StoriesRepository

    private var cancellables: [AnyCancellable] = []

    private var player: StoriesAudioPlayers?
    private var currentTimeTimer: Timer?

    init(metadata: StoriesSectionItem, selectedLanguage: SetLanguage) {
        self.metadata = metadata
        self.selectedLanguage = selectedLanguage
        repository = StoriesRepository()

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
            let sentences = try loadSentences()

            // TODO: transform data to reload
            state = .loaded(content:
                    .init(
                        headline: .init(image: metadata.image, title: metadata.title, subtitle: metadata.subtitle),
                        player: .init(
                            timer: .init(currentTime: 0, maxTime: player!.duration),
                            state: .paused,
                            languages: [selectedLanguage.language.main, selectedLanguage.language.source],
                            selectedLanguage: selectedLanguage.language.main
                        )
                    )
            )
        } catch {
            state = .error(message: error.localizedDescription)
            return
        }
    }

    private func initPlayers() throws {
        player = try StoriesAudioPlayers(slug: metadata.slug, selectedLanguage: selectedLanguage)
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
        print("button tapped: \(action)")

        switch action {
        case .play:
            play()
        case .pause:
            player?.pause()
        case .forward:
            player?.forward()
        case .backward:
            player?.backward()
        case .language(let selected):
            player?.switchLanguage()
        }
    }

    private func play() {
        player?.play()

        currentTimeTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            // TODO: update time in view
            print("\(self?.player?.currentTime)")
        }
    }

    private func pause() {
        player?.pause()

        currentTimeTimer?.invalidate()
    }
}

class StoriesAudioPlayers {

    private let mainPlayer: StoryAudioPlayer
    private let secondPlayer: StoryAudioPlayer

    private var currentPlayer: StoryAudioPlayer

    var duration: TimeInterval {
        currentPlayer.duration
    }

    var currentTime: TimeInterval {
        currentPlayer.currentTime
    }

    init(slug: String, selectedLanguage: SetLanguage) throws {
        let language = selectedLanguage.language
        mainPlayer = try StoryAudioPlayer(suffix: "\(slug)/\(language.main.rawValue)")
        secondPlayer = try StoryAudioPlayer(suffix: "\(slug)/\(language.source.rawValue)")

        self.currentPlayer = mainPlayer
    }

    func switchLanguage() {
        if currentPlayer == mainPlayer {
            currentPlayer = secondPlayer
        } else {
            currentPlayer = mainPlayer
        }
    }

    func play() {
        currentPlayer.play()
    }

    func pause() {
        currentPlayer.pause()
    }

    func stop() {
        currentPlayer.stop()
    }

    func forward() {
        currentPlayer.forward()
    }

    func backward() {
        currentPlayer.backward()
    }
}

class StoryAudioPlayer: Equatable {

    private let seekingStep: TimeInterval = 10

    private let avPlayer: AVAudioPlayer
    private var observer: NSKeyValueObservation?

    var duration: TimeInterval {
        avPlayer.duration
    }

    var currentTime: TimeInterval {
        avPlayer.currentTime
    }

    // MARK: - Initializer

    init(suffix: String) throws {
        guard let data = NSDataAsset(name: "data/stories/\(suffix)") else {
            throw AudioError(message: "File does not exists \(suffix)")
        }

        avPlayer = try AVAudioPlayer(data: data.data)
    }

    // MARK: - Functions

    func play() {
        avPlayer.play()
    }

    func pause() {
        avPlayer.pause()
    }

    func stop() {
        avPlayer.stop()
    }

    func forward() {
        if avPlayer.currentTime + seekingStep > avPlayer.duration {
            avPlayer.currentTime = avPlayer.duration
        } else {
            avPlayer.currentTime += seekingStep
        }
    }

    func backward() {
        if avPlayer.currentTime < seekingStep {
            avPlayer.currentTime = 0
        } else {
            avPlayer.currentTime -= 10
        }
    }

    static func == (lhs: StoryAudioPlayer, rhs: StoryAudioPlayer) -> Bool {
        lhs.avPlayer == rhs.avPlayer
    }
}

struct AudioError: Error {
    let message: String
}
