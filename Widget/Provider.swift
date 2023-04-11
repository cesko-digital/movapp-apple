//
//  Provider.swift
//  WidgetExtension
//
//  Created by Jakub Ruzicka on 08.04.2023.
//

import Intents
import WidgetKit

// swiftlint:disable void_return

struct Provider: TimelineProvider {

    let store = DictionaryDataStore()
    let userDefaults = UserDefaultsStore()

    init() {
        let language = userDefaults.getLanguage() ?? .csUk
        store.load(language: language)
    }

    func placeholder(in context: Context) -> FavoritePhraseEntry {
        FavoritePhraseEntry.example
    }

    func getSnapshot(in context: Context,
                     completion: @escaping (FavoritePhraseEntry) -> ()) {
        completion(FavoritePhraseEntry.example)
    }

    func getTimeline(in context: Context,
                     completion: @escaping (Timeline<FavoritePhraseEntry>) -> ()) {

        guard let phrases = store.dictionary?.phrases.values else {
            let timeline = Timeline(entries: [FavoritePhraseEntry.example], policy: .atEnd)
            return completion(timeline)
        }

        var entries: [FavoritePhraseEntry] = []
        let currentDate = Date()

        for hourOffset in 0 ..< 12 {

            if let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate),
               let phrase = phrases.randomElement() {
                entries.append(
                    .init(
                        date: entryDate,
                        translationFrom: phrase.main.translation,
                        translationTo: phrase.source.translation,
                        transcriptionFrom: phrase.main.transcription,
                        transcriptionTo: phrase.source.transcription
                    )
                )
            }
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// swiftlint:enable void_return
