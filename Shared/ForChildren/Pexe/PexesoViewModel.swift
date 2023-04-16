//
//  PexesoViewModel.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 17.10.2022.
//

import Foundation

struct PexesoContent {
    let imageName: String
    let translation: Dictionary.Phrase.Translation
    var selected: Bool
    var found: Bool
}

enum PexesoState {
    case loading
    case loaded(content: [PexesoContent])
    case won
    case error
}

protocol PexesoViewModeling: ObservableObject {
    var state: PexesoState { get }

    func load()
    func reset()
    func select(phrase: PexesoContent)
}

class PexesoViewModel: PexesoViewModeling {

    @Published var state: PexesoState = .loading

    private let repository: PexesoRepository
    private let soundService: SoundService
    private let numberOfPairs: Int = 12

    init(repository: PexesoRepository, soundService: SoundService) {
        self.repository = repository
        self.soundService = soundService
    }

    func load() {
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
        guard case .loaded(let content) = state else {
            return
        }

        // TODO: finish finding phrase in content and mark it as selected/found
    }

    func reset() {
        state = .loading

        load()
    }
}
