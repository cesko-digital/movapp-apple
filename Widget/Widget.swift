import Intents
import SwiftUI
import WidgetKit

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
        Color.secondary
            .frame(height: 1.0 / UIScreen.main.scale)
    }
}

struct MovappWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text("\(entry.translationFrom)")
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
            Text("[ \(entry.transcriptionFrom) ]")
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            HairlineSeparator()

            Text("\(entry.translationTo)")
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
            Text("[ \(entry.transcriptionTo) ]")
                .foregroundColor(.secondary)
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
