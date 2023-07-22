//
//  ExerciseRootViewModel.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 26.05.2023.
//

import Combine
import Foundation

struct ExerciseRootContent {
    let categories: [Category]
    let configuration: Configuration

    struct Category {
        let id: String
        let name: String
        let selected: Bool
    }

    struct Configuration {
        let sizeList: [Int]
        let sizeDefault: Int
    }
}

enum ExerciseRootState {
    case loading
    case loaded(ExerciseRootContent)
    case error
}

protocol ExerciseRootViewModeling: ObservableObject {
    var state: ExerciseRootState { get }
    var viewAppeared: PassthroughSubject<Void, Never> { get }

    func selectCategory(id: String)
}

final class ExerciseRootViewModel: ExerciseRootViewModeling {
    @Published private(set) var state: ExerciseRootState = .loading

    let viewAppeared = PassthroughSubject<Void, Never>()

    private var cancellables: [AnyCancellable] = []
    private let language: SetLanguage
    private let exerciseConfigurationRepository: ExerciseConfigurationRepositoryType

    init(
        language: SetLanguage,
        exerciseConfigurationRepository: ExerciseConfigurationRepositoryType
    ) {
        self.language = language
        self.exerciseConfigurationRepository = exerciseConfigurationRepository

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
        let configuration = exerciseConfigurationRepository.load(for: language)

        state = ExerciseRootState.loaded(
            ExerciseRootContent(
                categories: configuration.categories.map { .init(id: $0.id, name: $0.name, selected: false)},
                configuration: .init(sizeList: configuration.configuration.sizeList,
                                     sizeDefault: configuration.configuration.sizeDefault)
            )
        )
    }

    func selectCategory(id: String) {
        // TODO: implement this
    }
}
