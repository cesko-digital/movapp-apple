//
//  ForChildrenViewModeling.swift
//  MovappWatch Watch App
//
//  Created by Jakub Ruzicka on 15.04.2023.
//

import Combine
import Foundation

enum ForChildrenState {
    case loading
    case error
    case loaded(ForChildrenContent)
}

struct ForChildrenContent {
    let phrases: [Dictionary.Phrase]
}

protocol ForChildrenViewModeling: ObservableObject {

    var state: ForChildrenState { get }
    var viewAppeared: PassthroughSubject<Void, Never> { get }
}

class ForChildrenViewModel: ForChildrenViewModeling {

    private let dataStore: ForChildrenDataStore
    private let dictionaryDataStore: DictionaryDataStore
    private let language: SetLanguage?
    private var cancellables: [AnyCancellable] = []

    @Published var state: ForChildrenState = .loading
    let viewAppeared = PassthroughSubject<Void, Never>()

    init(dataStore: ForChildrenDataStore, dictionaryDataStore: DictionaryDataStore, language: SetLanguage?) {
        self.dataStore = dataStore
        self.dictionaryDataStore = dictionaryDataStore
        self.language = language

        bind()
    }

    private func bind() {
        viewAppeared
            .sink { [weak self] in
                self?.load()
            }
            .store(in: &cancellables)
    }

    private func load() {
        guard let language = language else {
            state = .error
            return
        }

        dictionaryDataStore.load(language: language)

        dataStore.load()

        guard let phrases = dataStore.forChildren else {
            state = .error
            return
        }

        state = .loaded(ForChildrenContent(phrases: phrases))
    }
}
