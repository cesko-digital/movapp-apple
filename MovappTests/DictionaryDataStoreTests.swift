//
//  DictionaryDataStoreTests.swift
//  MovappTests
//
//  Created by Jakub Ruzicka on 25.03.2023.
//

import XCTest
@testable import Movapp

final class DictionaryDataStoreTests: XCTestCase {

    func testLoadCsUk() throws {
        let dataStore = DictionaryDataStore()

        dataStore.load(language: .csUk)

        XCTAssertFalse(dataStore.loading)
        XCTAssertNil(dataStore.error)
        XCTAssertNotNil(dataStore.dictionary)

        dataStore.dictionary?.phrases.values.forEach { phrase in
            if let soundFileName = phrase.source.soundFileName {
                let sound = NSDataAsset(name: "data/uk-sounds/\(soundFileName)")
                XCTAssertNotNil(sound)
            }
        }

        dataStore.dictionary?.phrases.values.forEach { phrase in
            if let soundFileName = phrase.main.soundFileName {
                let sound = NSDataAsset(name: "data/cs-sounds/\(soundFileName)")
                XCTAssertNotNil(sound, "\(soundFileName) not found \(phrase.main.soundUrl)")
            }
        }
    }

    func testLoadPlUk() throws {
        let dataStore = DictionaryDataStore()

        dataStore.load(language: .plUk)

        XCTAssertFalse(dataStore.loading)
        XCTAssertNil(dataStore.error)
        XCTAssertNotNil(dataStore.dictionary)
    }

    func testLoadSkUk() throws {
        let dataStore = DictionaryDataStore()

        dataStore.load(language: .skUk)

        XCTAssertFalse(dataStore.loading)
        XCTAssertNil(dataStore.error)
        XCTAssertNotNil(dataStore.dictionary)
    }

    func testLoadUkCs() throws {
        let dataStore = DictionaryDataStore()

        dataStore.load(language: .ukCs)

        XCTAssertFalse(dataStore.loading)
        XCTAssertNil(dataStore.error)
        XCTAssertNotNil(dataStore.dictionary)
    }

    func testLoadUkPl() throws {
        let dataStore = DictionaryDataStore()

        dataStore.load(language: .ukPl)

        XCTAssertFalse(dataStore.loading)
        XCTAssertNil(dataStore.error)
        XCTAssertNotNil(dataStore.dictionary)
    }

    func testLoadUkSk() throws {
        let dataStore = DictionaryDataStore()

        dataStore.load(language: .ukSk)

        XCTAssertFalse(dataStore.loading)
        XCTAssertNil(dataStore.error)
        XCTAssertNotNil(dataStore.dictionary)
    }
}
