//
//  ExerciseRootViewModel.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 26.05.2023.
//

import Combine
import Foundation

struct ExerciseRootContent {

}

enum ExerciceRootState {
    case loading
    case loaded(ExerciseRootContent)
    case error
}

protocol ExerciseRootViewModeling: ObservableObject {

}

final class ExerciseRootViewModel: ExerciseRootViewModeling {
    @Published private(set) var state: ExerciceRootState = .loading

    let viewAppeared = PassthroughSubject<Void, Never>()

    private var cancellables: [AnyCancellable] = []

    init() {
        bind()
    }

    func bind() {
        viewAppeared
            .sink { [weak self] in
                self?.load()
            }
            .store(in: &cancellables)
    }

    private func load() {

    }
}
