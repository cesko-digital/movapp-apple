//
//  AlphabetViewModeling.swift
//  MovappWatch Watch App
//
//  Created by Jakub Ruzicka on 15.04.2023.
//

import Combine
import Foundation

enum AlphabetState {
    case loading
    case error
    case loaded([AlphabetContent])
}

struct AlphabetContent {
    let language: Languages
    let alphabet: Alphabet
}

protocol AlphabetViewModeling: ObservableObject {

    var state: AlphabetState { get }
    var viewAppeared: PassthroughSubject<Void, Never> { get }
}

class AlphabetViewModel: AlphabetViewModeling {

    private let dataStore: AlphabetDataStore
    private let language: SetLanguage?
    private var cancellables: [AnyCancellable] = []

    @Published var state: AlphabetState = .loading
    let viewAppeared = PassthroughSubject<Void, Never>()

    init(dataStore: AlphabetDataStore, language: SetLanguage?) {
        self.dataStore = dataStore
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

        let languages = [
            language.language.main,
            language.language.source
        ]

        do {
            let firstLanguage = languages[0]
            let firstAlphabet = try dataStore.load(with: language, alphabet: firstLanguage)
            let secondLanguage = languages[1]
            let secondAlphabet = try dataStore.load(with: language, alphabet: secondLanguage)

            self.state = .loaded(
                [
                    AlphabetContent(language: firstLanguage, alphabet: firstAlphabet),
                    AlphabetContent(language: secondLanguage, alphabet: secondAlphabet)
                ]
            )
        } catch {
            self.state = .error
        }
    }
}
