//
//  FlipView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 19.10.2022.
//

import SwiftUI

struct FlipView: View {
    @State private var backDegree = 0.0
    @State private var frontDegree = -90.0
    @State private var isFlipped = false

    private let durationAndDelay: CGFloat = 0.3

    let content: PexesoContent
    let flipped: (PexesoContent) -> Void

    func flipCard () {
        guard !content.found else { return }

        flipped(content)

        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                backDegree = 0
            }
        }
    }

    var body: some View {
        ZStack {
            CardFront(degree: $frontDegree, imageName: content.phrase.imageName!)
            CardBack(degree: $backDegree)
        }.onTapGesture {
            flipCard()
        }
    }
}

struct FlipView_Previews: PreviewProvider {
    static var previews: some View {
        FlipView(content: .init(phrase: examplePhrase, selected: false, found: false)) { _ in }
    }
}
