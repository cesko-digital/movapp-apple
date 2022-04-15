import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    let store = DictionaryDataStore()
    
    init() {
        store.load(language: .csUk)
    }
    
    func placeholder(in context: Context) -> FavoritePhraseEntry {
        FavoritePhraseEntry.example()
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (FavoritePhraseEntry) -> ()) {
        completion(FavoritePhraseEntry.example())
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        guard let phrases = store.dictionary?.translations.values else {
            let timeline = Timeline(entries: [FavoritePhraseEntry.example(intent: configuration)], policy: .atEnd)
            return completion(timeline)
        }
        
        var entries: [FavoritePhraseEntry] = []
        let currentDate = Date()
        
        for hourOffset in 0 ..< 2 {
            
            if let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate),
               let phrase = phrases.randomElement()
            {
                entries.append(
                    .init(
                        date: entryDate,
                        translationFrom: phrase.translationFrom,
                        translationTo: phrase.translationTo,
                        transcriptionFrom: phrase.transcriptionFrom,
                        transcriptionTo: phrase.transcriptionTo,
                        configuration: configuration
                    )
                )
            }
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

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

struct Movapp_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("\(entry.translationFrom)")
                .foregroundColor(.black)
            Text("[ \(entry.transcriptionFrom) ]")
                .foregroundColor(.gray)
            
            HairlineSeparator()
            
            Text("\(entry.translationTo)")
                .foregroundColor(.black)
            Text("[ \(entry.transcriptionTo) ]")
                .foregroundColor(.gray)
        }
        .padding()
    }
}

@main
struct Movapp_Widget: Widget {
    let kind: String = "Movapp_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Movapp_WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Movapp Widget")
        .description("Every hour it displays one of phrases.")
    }
}

struct Movapp_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Movapp_WidgetEntryView(entry: FavoritePhraseEntry.example())
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
