//
//  AlphabetDetailView.swift
//  MovappWatch Watch App
//
//  Created by Jakub Ruzicka on 15.04.2023.
//

import SwiftUI

struct AlphabetDetailView: View {

    let content: Alphabet

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(Array(content.items.enumerated()), id: \.offset) { offset, item in
                    Text(item.letter)
                        .font(.largeTitle)
                    Text(item.transcription)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 4)

                    ForEach(Array(item.examples.enumerated()), id: \.element.translation) { _, example in
                        Text(example.translation)
                        Text("[\(example.transcription)]")
                            .foregroundColor(.secondary)
                    }

                    if offset < content.items.count - 1 {
                        Divider()
                    }
                }
            }
            .padding(8)
        }
    }
}

struct AlphabetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlphabetDetailView(content: .example)
    }
}
