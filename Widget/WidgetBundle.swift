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
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MovappWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("widget.configuration.title")
        .description("widget.configuration.description")
    }
}
