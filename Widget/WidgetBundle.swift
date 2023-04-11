//
//  WidgetBundle.swift
//  Widget
//
//  Created by Jakub Ruzicka on 08.04.2023.
//

import WidgetKit
import SwiftUI

@main
struct MovappWidget: Widget {
    let kind: String = "Movapp_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MovappWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Movapp Widget")
        .description("Every hour it displays one of phrases.")
    }
}
