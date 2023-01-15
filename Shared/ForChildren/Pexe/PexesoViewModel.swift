//
//  PexesoViewModel.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 17.10.2022.
//

import Foundation

struct PexesoContent {
    var phrase: Dictionary.Phrase
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

    private var repository: PexesoRepository
    private let numberOfPairs: Int = 12

    init(repository: PexesoRepository) {
        self.repository = repository
    }

    func load() {
        guard let source = repository.load()?.shuffled().prefix(numberOfPairs), !source.isEmpty else {
            state = .error
            return
        }

        let pexeso = source + source.shuffled()

        state = .loaded(content: pexeso.shuffled().map {
            PexesoContent(phrase: $0, selected: false, found: false)
        })
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
