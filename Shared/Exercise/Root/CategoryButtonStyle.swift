//
//  CategoryButtonStyle.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 18.06.2023.
//

import Foundation
import SwiftUI

struct CategoryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(8)
            .foregroundColor(.black)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white).buttonBorderShape(.roundedRectangle))
            .scaleEffect(configuration.isPressed ? 1.05 : 1.0)
            .animation(.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1), value: configuration.isPressed)
    }
}

struct CategoryButtonSelectedStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(8)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color("colors/primary")))
            .scaleEffect(configuration.isPressed ? 1.05 : 1.0)
            .animation(.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1), value: configuration.isPressed)
    }
}

struct CategoryButtonStyle_Previews: PreviewProvider {

    static var previews: some View {
        VStack(spacing: 10) {
            Button("Text") { }
                .buttonStyle(CategoryButtonStyle())

            Button("Text") { }
                .buttonStyle(CategoryButtonSelectedStyle())
        }
    }
}
