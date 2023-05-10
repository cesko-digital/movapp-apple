//
//  CardBack.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 19.10.2022.
//

import SwiftUI

struct CardBack: View {

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)

            Image("pexeso/cardBackground")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
        }
    }
}

struct CardBack_Previews: PreviewProvider {
    static var previews: some View {
        CardBack()
    }
}
