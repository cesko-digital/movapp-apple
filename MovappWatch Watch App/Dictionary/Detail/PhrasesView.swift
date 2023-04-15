//
//  PhraseView.swift
//  MovappWatch Watch App
//
//  Created by Jakub Ruzicka on 15.04.2023.
//

import Foundation

import SwiftUI

struct PhrasesView: View {
    let phrases: [Dictionary.Phrase]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(Array(phrases.enumerated()), id: \.offset) { offset, item in
                    phraseView(content: item)

                    if offset < phrases.count - 1 {
                        Divider()
                    }
                }
            }
            .padding(8)
        }
    }

    private func phraseView(content: Dictionary.Phrase) -> some View {
        VStack(alignment: .leading) {
            Text(content.main.translation)
            Text("[\(content.main.transcription)]")
                .foregroundColor(.secondary)
            Spacer()
            Text(content.source.translation)
            Text("[\(content.source.transcription)]")
                .foregroundColor(.secondary)
        }
    }
}

struct PhrasesView_Previews: PreviewProvider {
    static var previews: some View {
        PhrasesView(phrases: [examplePhrase, examplePhrase])
    }
}
