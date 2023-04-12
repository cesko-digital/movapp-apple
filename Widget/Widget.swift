import Intents
import SwiftUI
import WidgetKit

struct FavoritePhraseEntry: TimelineEntry {
    let date: Date
    let id: String
    let translationFrom: String
    let translationTo: String
    let transcriptionFrom: String
    let transcriptionTo: String

    static var example: FavoritePhraseEntry {
        .init(
            date: Date(),
            id: "recwA7uQYnXczMqOb",
            translationFrom: "Dobrý den",
            translationTo: "Добрий день.",
            transcriptionFrom: "Dobrý den",
            transcriptionTo: "Dobryj deň"
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

            primaryText("\(entry.translationFrom)")
            secondaryText("[ \(entry.transcriptionFrom) ]")

            HairlineSeparator()

            primaryText("\(entry.translationTo)")
            secondaryText("[ \(entry.transcriptionTo) ]")
        }
        .widgetURL(Deeplink.phrase(entry.id).url)
        .padding()
    }

    func primaryText(_ text: String) -> some View {
        Text("\(text)")
            .foregroundColor(.primary)
            .minimumScaleFactor(0.1)
    }

    func secondaryText(_ text: String) -> some View {
        Text("\(text)")
            .foregroundColor(.secondary)
            .minimumScaleFactor(0.5)
    }
}

struct MovappWidgetPreviews: PreviewProvider {
    static var previews: some View {
        MovappWidgetEntryView(entry: FavoritePhraseEntry.example)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
