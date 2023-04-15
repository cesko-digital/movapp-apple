//
//  DictionaryViewModel.swift
//  MovappWatch Watch App
//
//  Created by Jakub Ruzicka on 15.04.2023.
//

import Combine
import Foundation

enum DictionaryState {
    case loading
    case error
    case loaded(DictionaryContent)
}

struct DictionaryContent {
    let categories: [DictionaryCategory]
}

struct DictionaryCategory {
    let name: Dictionary.Category.Name
    let phrases: [Dictionary.Phrase]
}

protocol DictionaryViewModeling: ObservableObject {

    var state: DictionaryState { get }
    var viewAppeared: PassthroughSubject<Void, Never> { get }
}

class DictionaryViewModel: DictionaryViewModeling {

    private let dataStore: DictionaryDataStore
    private let userDefaults: UserDefaultsStore
    private var cancellables: [AnyCancellable] = []

    @Published var state: DictionaryState = .loading
    let viewAppeared = PassthroughSubject<Void, Never>()

    init(dataStore: DictionaryDataStore, userDefaults: UserDefaultsStore) {
        self.dataStore = dataStore
        self.userDefaults = userDefaults

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
        // TODO: WatchOS app cannot read iOS app User Defaults, I must use Watch Connectivity
        // let language = userDefaults.getLanguage() ?? .csUk

        /*
        guard let language = userDefaults.getLanguage() else {
            state = .error
            return
        }
        */

        dataStore.load(language: .csUk)

        guard let dictionary = dataStore.dictionary else {
            state = .error
            return
        }

        var categories: [DictionaryCategory] = []

        for category in dictionary.categories {
            categories.append(DictionaryCategory(name: category.name,
                                                 phrases: dictionary.phrases.filter(identifiers: category.phrases)))
        }

        state = .loaded(DictionaryContent(categories: categories))
    }
}
