//
//  CategoryButtonStyle.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 18.06.2023.
//

import Foundation
import SwiftUI

struct CategoryButtonStyle: ButtonStyle {
    var selected: Bool = false

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(8)
            .foregroundColor(selected ? .white : .black)
            .background(RoundedRectangle(cornerRadius: 8)
                .foregroundColor(selected ? Color("colors/primary") : .white)
                    .buttonBorderShape(.roundedRectangle))
            .scaleEffect(configuration.isPressed ? 1.05 : 1.0)
            .animation(.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1), value: configuration.isPressed)
    }
}

struct CategoryButtonStyle_Previews: PreviewProvider {

    static var previews: some View {
        VStack(spacing: 10) {
            Button("Text") { }
                .buttonStyle(CategoryButtonStyle(selected: false))

            Button("Text") { }
                .buttonStyle(CategoryButtonStyle(selected: true))
        }
    }
}
