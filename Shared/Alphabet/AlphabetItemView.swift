//
//  AlphabetItemView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 10.04.2022.
//

import SwiftUI

struct AlphabetItemView: View {
    let item: AlphabetItem

    init (item: AlphabetItem) {
        self.item = item
    }

    var body: some View {
        CardView {
            Content {
                Text(item.letter)
                    .font(.system(size: 100))
                    .foregroundColor(Color("colors/text"))

                if let soundFileName = item.soundFileName {
                    PlayButtonView(soundFileName: soundFileName)
                }

                Text(item.transcription)
                    .font(.system(size: 25))
                    .foregroundColor(Color("colors/text"))
            }
            Footer {
                ForEach(item.examples, id: \.translation) { example in
                    HStack {
                        Text(example.translation)
                            .foregroundColor(Color("colors/text"))

                        Spacer()

                        Text("[\(example.transcription)]")
                            .foregroundColor(Color("colors/secondary"))

                        Spacer()

                        PlayTranslationButtonView(translation: example)

                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }

}

struct AlphabetItemView_Previews: PreviewProvider {
    static let soundService = SoundService()

    static var previews: some View {
        AlphabetItemView(item: AlphabetItem.example)
            .environmentObject(soundService)
    }
}
