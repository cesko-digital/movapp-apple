//
//  FlipView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 19.10.2022.
//

import SwiftUI

struct FlipView: View {
    @State private var scale: CGFloat = 1.0

    private let durationAndDelay: CGFloat = 0.3

    var content: PexesoContent
    let flipped: (PexesoContent) -> Void

    var body: some View {
        ZStack {
            if content.selected || content.found {
                CardFront(imageName: content.imageName)
                    .scaleEffect(scale)
            } else {
                CardBack()
                    .scaleEffect(scale)
            }
        }.onTapGesture {
            scale = 0.9
            flipped(content)
            withAnimation {
                scale = 1.0
            }
        }
    }
}

struct FlipView_Previews: PreviewProvider {
    static var previews: some View {
        FlipView(content: .init(imageName: "images/rec00jYJm8WGf61L3",
                                translation: examplePhrase.main,
                                selected: false,
                                found: false)) { _ in }
    }
}
