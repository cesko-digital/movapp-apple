//
//  ExerciseConfigurationTests.swift
//  MovappTests
//
//  Created by Jakub Ruzicka on 26.05.2023.
//

import XCTest
@testable import Movapp

final class ExerciseConfigurationTests: XCTestCase {

    func testLoadConfiguration() throws {
        let repository = ExerciseConfigurationRepository(dictionaryRepository: DictionaryRepository())

        let result = repository.load(for: .csUk)

        XCTAssertNotNil(result)
        XCTAssertFalse(result.categories.isEmpty)
    }
}
