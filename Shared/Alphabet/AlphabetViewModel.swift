//
//  AlphabetViewModel.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 31.08.2022.
//

import Foundation
import Combine

struct AlphabetContent {
    let language: Languages
    let alphabet: Alphabet
}

enum AlphabetState {
    case loading
    case loaded([AlphabetContent])
    case error(String)
}

protocol AlphabetViewModeling: ObservableObject {
    var state: AlphabetState { get }
    var selectedAlphabet: Languages { get set }
}

class AlphabetViewModel: AlphabetViewModeling {
    private let dataStore: AlphabetDataStore
    private let languageStore: LanguageStore
    private var cancellables: [AnyCancellable] = []

    @Published var state: AlphabetState = .loading
    @Published var selectedAlphabet: Languages

    init(dataStore: AlphabetDataStore, languageStore: LanguageStore) {
        self.dataStore = dataStore
        self.languageStore = languageStore

        let languagesList = [
            languageStore.currentLanguage.language.main,
            languageStore.currentLanguage.language.source
        ]

        // Always show the alphabet of a language im learning
        let languages = languageStore.currentLanguage.flipFromWithTo ? languagesList : languagesList.reversed()

        self.selectedAlphabet = languages.first!

        bind()
    }

    private func bind() {
        languageStore.$currentLanguage
            .sink { [weak self] selectedLanguage in
                self?.load(selectedLanguage: selectedLanguage)
            }
            .store(in: &cancellables)
    }

    func load() {
        load(selectedLanguage: languageStore.currentLanguage)
    }

    private func load(selectedLanguage: SetLanguage) {
        let languagesList = [
            selectedLanguage.language.main,
            selectedLanguage.language.source
        ]

        // Always show the alphabet of a language im learning
        let languages = selectedLanguage.flipFromWithTo ? languagesList : languagesList.reversed()

        do {
            let firstLanguage = languages[0]
            let firstAlphabet = try dataStore.load(with: selectedLanguage, alphabet: firstLanguage)
            let secondLanguage = languages[1]
            let secondAlphabet = try dataStore.load(with: selectedLanguage, alphabet: secondLanguage)

            self.selectedAlphabet = firstLanguage
            self.state = .loaded(
                [
                    AlphabetContent(language: firstLanguage, alphabet: firstAlphabet),
                    AlphabetContent(language: secondLanguage, alphabet: secondAlphabet)
                ]
            )
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }
}
