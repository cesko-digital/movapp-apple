//
//  CardBack.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 19.10.2022.
//

import SwiftUI

struct CardBack: View {
    @Binding var degree: Double

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)

            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardBack_Previews: PreviewProvider {
    static var previews: some View {
        CardBack(degree: .constant(0))
    }
}
