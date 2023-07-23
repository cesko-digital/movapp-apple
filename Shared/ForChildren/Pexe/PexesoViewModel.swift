//
//  PexesoViewModel.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 17.10.2022.
//

import Foundation
import Combine

struct PexesoContent: Identifiable {
    var id: String { "\(imageName)+\(translation.translation)" }
    let imageName: String
    let translation: Dictionary.Phrase.Translation
    let selected: Bool
    let found: Bool
}

enum PexesoState {
    case loading
    case loaded(content: [PexesoContent])
    case won(content: [PexesoContent])
    case error
}

protocol PexesoViewModeling: ObservableObject {
    var state: PexesoState { get }
    var viewAppeared: PassthroughSubject<Void, Never> { get }

    func reset()
    func select(phrase: PexesoContent)
}

class PexesoViewModel: PexesoViewModeling {

    @Published private(set) var state: PexesoState = .loading

    let viewAppeared = PassthroughSubject<Void, Never>()

    private let repository: PexesoRepository
    private let soundService: SoundService
    private let numberOfPairs: Int = 8
    private var cancellables: [AnyCancellable] = []
    private var selectedPhrases: [PexesoContent] = []
    private var canRotate: Bool = true

    init(repository: PexesoRepository, soundService: SoundService) {
        self.repository = repository
        self.soundService = soundService

        bind()
    }

    func bind() {
        viewAppeared
            .sink { [weak self] in
                self?.load()
            }
            .store(in: &cancellables)

        soundService.$isPlaying
            .receive(on: RunLoop.main)
            .sink { [weak self] isPlaying in
                self?.canRotate = !isPlaying
                if isPlaying == false {
                    self?.validateSelected()
                }
            }
            .store(in: &cancellables)
    }

    private func load() {
        guard let source = repository.load()?.shuffled().prefix(numberOfPairs), !source.isEmpty else {
            state = .error
            return
        }

        let pexeso = source.map {
            PexesoContent(imageName: $0.imageName!,
                          translation: $0.main,
                          selected: false,
                          found: false)
        } + source.shuffled().map {
            PexesoContent(imageName: $0.imageName!,
                          translation: $0.source,
                          selected: false,
                          found: false)
        }

        state = .loaded(content: pexeso.shuffled())
    }

    func select(phrase: PexesoContent) {
        guard canRotate else { return }
        guard !phrase.selected else { return }

        guard case .loaded(let content) = state else {
            return
        }

        let notFoundYet = content.filter({ !$0.found })

        guard !notFoundYet.isEmpty else {
            won(content)
            return
        }

        guard selectedPhrases.count != 2 else { return }

        selectedPhrases.append(phrase)

        remake(selectedIds: selectedPhrases.compactMap { $0.id })
        soundService.play(path: phrase.translation.soundFileName)
    }

    func reset() {
        state = .loading

        load()
    }

    private func validateSelected() {
        guard selectedPhrases.count == 2 else {
            return
        }

        let isMatching = selectedPhrases[0].imageName == selectedPhrases[1].imageName

        remake(found: isMatching ? selectedPhrases[0].imageName : nil)

        selectedPhrases.removeAll()

        validateAll()
    }

    private func validateAll() {
        guard case .loaded(let content) = state else {
            return
        }

        let notFoundYet = content.filter({ !$0.found })

        guard !notFoundYet.isEmpty else {
            won(content)
            return
        }
    }

    private func remake(found: String? = nil, selectedIds: [String] = []) {
        guard case .loaded(let content) = state else {
            return
        }

        state = .loaded(content: content.map {
            PexesoContent(imageName: $0.imageName,
                          translation: $0.translation,
                          selected: selectedIds.contains($0.id),
                          found: $0.found || found == $0.imageName)
        })
    }

    private func won(_ content: [PexesoContent]) {
        state = .won(content: content.map {
            .init(imageName: $0.imageName, translation: $0.translation, selected: true, found: true)
        })
        soundService.play(path: "pexeso/win_music")
    }
}
