//
//  ExerciseConfigurationRepository.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 26.05.2023.
//

import Foundation

struct ExerciseCategory {
    let id: String
    let name: String
}

struct ExerciseConfigurationProperties {
    let sizeList: [Int]
    let sizeDefault: Int
    let leveldefault: Int
    let levelMin: Int
    let levelMax: Int
    let levelDownThresholdScore: Int
    let levelUpThresholdScore: Int
}

struct ExerciseConfiguration {
    let categories: [ExerciseCategory]
    let configuration: ExerciseConfigurationProperties
}

protocol ExerciseConfigurationRepositoryType {
    func load(for language: SetLanguage) -> ExerciseConfiguration
}

final class ExerciseConfigurationRepository: ExerciseConfigurationRepositoryType {

    private let dictionaryRepository: DictionaryRepositoryType

    init(dictionaryRepository: DictionaryRepositoryType) {
        self.dictionaryRepository = dictionaryRepository
    }

    func load(for language: SetLanguage) -> ExerciseConfiguration {
        guard let dictionary = try? dictionaryRepository.load(language: language) else {
            preconditionFailure("Dictionary is not loaded.")
        }

        let categories = dictionary.categories.filter({ $0.isMetaCategory })

        guard categories.isEmpty == false else {
            preconditionFailure("There is not meta categories.")
        }

        return ExerciseConfiguration(categories: categories.map { ExerciseCategory(id: $0.id,
                                                                                     name: $0.name.main) },
                                     configuration: getProperties())
    }

    private func getProperties() -> ExerciseConfigurationProperties {
        #if DEBUG
        ExerciseConfigurationProperties(sizeList: [1, 5, 10],
                                        sizeDefault: 1,
                                        leveldefault: 0,
                                        levelMin: 0,
                                        levelMax: 1,
                                        levelDownThresholdScore: 50,
                                        levelUpThresholdScore: 100)
        #else
        ExerciseConfigurationProperties(sizeList: [10, 20, 30],
                                        sizeDefault: 10,
                                        leveldefault: 0,
                                        levelMin: 0,
                                        levelMax: 1,
                                        levelDownThresholdScore: 50,
                                        levelUpThresholdScore: 100)
        #endif
    }
}
