//
//  FlipView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 19.10.2022.
//

import SwiftUI

struct FlipView: View {
    private let durationAndDelay: CGFloat = 0.3

    var content: PexesoContent
    let flipped: (PexesoContent) -> Void

    var body: some View {
        ZStack {
            if content.selected || content.found {
                CardFront(imageName: content.imageName)
            } else {
                CardBack()
            }
        }.onTapGesture {
            flipped(content)
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
