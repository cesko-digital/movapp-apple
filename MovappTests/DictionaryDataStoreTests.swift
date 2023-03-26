//
//  DictionaryDataStoreTests.swift
//  MovappTests
//
//  Created by Jakub Ruzicka on 25.03.2023.
//

import XCTest
@testable import Movapp

final class DictionaryDataStoreTests: XCTestCase {

    private func loadTest(dataStore: DictionaryDataStore, language: SetLanguage) {
        dataStore.load(language: language)

        XCTAssertFalse(dataStore.loading, "DataStore should be finished loading.")
        XCTAssertNil(dataStore.error, "DataStore should not have an error.")
        XCTAssertNotNil(dataStore.dictionary, "DataStore has empty dictionary.")

        dataStore.dictionary?.phrases.values.forEach { phrase in
            if let soundFileName = phrase.source.soundFileName {
                let sound = NSDataAsset(name: "data/\(soundFileName)")
                XCTAssertNotNil(sound, "\(soundFileName) not found at data/\(soundFileName)")
            } else {
                XCTFail("There is issue with phrase: \(phrase.source.soundUrl)")
            }

            if let soundFileName = phrase.main.soundFileName {
                let sound = NSDataAsset(name: "data/\(soundFileName)")
                XCTAssertNotNil(sound, "\(soundFileName) not found at data/\(soundFileName)")
            } else {
                XCTFail("There is issue with phrase: \(phrase.main.soundUrl)")
            }
        }
    }

    func testLoadingOfAllLanguages() throws {
        let dataStore = DictionaryDataStore()

        SetLanguage.allCases.forEach { language in
            loadTest(dataStore: dataStore, language: language)
        }
    }

    func testSoundUri() throws {
        guard let data = """
{
            "id": "recFQHFo2OtF3lBF0",
            "main": {
                "sound_url": "https://data.movapp.eu/cs-sounds/e/e3b41247a6db5f4844cb4d31d66994e7.mp3",
                "translation": "Potřebuji převést peníze z účtu ... na účet ...",
                "transcription": "Потршебуї пршевест пенізе з учту  на учет "
            },
            "source": {
                "sound_url": "https://data.movapp.eu/uk-sounds/5/5bfad1e5b1a51d4623f286d325b37649.mp3",
                "translation": "Мені потрібно перевести гроші з рахунку ... на рахунок ...",
                "transcription": "Meni potribno perevesty hroši z rachunku  na rachunok "
            },
            "image_url": null
        }
""".data(using: .utf16) else {
            XCTFail("Cannot convert json to data.")
            return
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let decodedPhrase = try decoder.decode(Dictionary.Phrase.self, from: data)

        XCTAssertEqual(decodedPhrase.main.soundFileName, "cs-sounds/e/e3b41247a6db5f4844cb4d31d66994e7")
        XCTAssertEqual(decodedPhrase.source.soundFileName, "uk-sounds/5/5bfad1e5b1a51d4623f286d325b37649")
    }
}
