import WidgetKit
import SwiftUI
import Intents

// swiftlint:disable void_return

struct Provider: IntentTimelineProvider {

    let store = DictionaryDataStore()
    let userDefaults = UserDefaultsStore()

    init() {
        let language = userDefaults.getLanguage() ?? .csUk
        store.load(language: language)
    }

    func placeholder(in context: Context) -> FavoritePhraseEntry {
        FavoritePhraseEntry.example()
    }

    func getSnapshot(for configuration: ConfigurationIntent,
                     in context: Context,
                     completion: @escaping (FavoritePhraseEntry) -> ()) {
        completion(FavoritePhraseEntry.example())
    }

    func getTimeline(for configuration: ConfigurationIntent,
                     in context: Context,
                     completion: @escaping (Timeline<FavoritePhraseEntry>) -> ()) {

        guard let phrases = store.dictionary?.phrases.values else {
            let timeline = Timeline(entries: [FavoritePhraseEntry.example(intent: configuration)], policy: .atEnd)
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
                        transcriptionTo: phrase.source.transcription,
                        configuration: configuration
                    )
                )
            }
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// swiftlint:enable void_return

struct FavoritePhraseEntry: TimelineEntry {
    let date: Date
    let translationFrom: String
    let translationTo: String
    let transcriptionFrom: String
    let transcriptionTo: String
    let configuration: ConfigurationIntent

    static func example(intent: ConfigurationIntent = ConfigurationIntent()) -> FavoritePhraseEntry {
        .init(
            date: Date(),
            translationFrom: "Dobrý den",
            translationTo: "Добрий день.",
            transcriptionFrom: "Dobrý den",
            transcriptionTo: "Dobryj deň",
            configuration: intent
        )
    }
}

struct HairlineSeparator: View {

    var body: some View {
        Color.gray
            .frame(height: 1.0 / UIScreen.main.scale)
    }
}

struct MovappWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text("\(entry.translationFrom)")
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
            Text("[ \(entry.transcriptionFrom) ]")
                .foregroundColor(.gray)
                .fixedSize(horizontal: false, vertical: true)

            HairlineSeparator()

            Text("\(entry.translationTo)")
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
            Text("[ \(entry.transcriptionTo) ]")
                .foregroundColor(.gray)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
    }
}

struct MovappWidgetPreviews: PreviewProvider {
    static var previews: some View {
        MovappWidgetEntryView(entry: FavoritePhraseEntry.example())
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
