//
//  CardFront.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 19.10.2022.
//

import SwiftUI

struct CardFront: View {
    @Binding var degree: Double
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
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardFront_Previews: PreviewProvider {
    static var previews: some View {
        CardFront(degree: .constant(0),
                  imageName: "images/rec00jYJm8WGf61L3")
    }
}
