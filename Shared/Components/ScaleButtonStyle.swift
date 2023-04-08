//
//  ScaleButtonStyle.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.05.2022.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.05 : 1.0)
            .animation(.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1), value: configuration.isPressed)
    }
}
