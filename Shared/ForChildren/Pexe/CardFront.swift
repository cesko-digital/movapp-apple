//
//  CardFront.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 19.10.2022.
//

import SwiftUI

struct CardFront: View {
    let imageName: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)

            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 375)
                .padding(4)
        }
    }
}

struct CardFront_Previews: PreviewProvider {
    static var previews: some View {
        CardFront(imageName: "images/rec00jYJm8WGf61L3")
    }
}
