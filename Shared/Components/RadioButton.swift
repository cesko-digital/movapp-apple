//
//  RadioButton.swift
//  Movapp (iOS)
//
//  Created by Ondra Kandera on 04.10.2023.
//

import SwiftUI

struct RadioButton: View {
    @ScaledMetric(relativeTo: .body) private var size: CGFloat = 20
    @ScaledMetric(relativeTo: .body) private var lineWidth: CGFloat = 1.5

    private let isSelected: Bool

    init(isSelected: Bool) {
        self.isSelected = isSelected
    }

    var body: some View {
        if isSelected {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFill()
                .foregroundColor(Color("colors/primary"))
                .frame(width: size + lineWidth, height: size + lineWidth)
        } else {
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(Color(UIColor.tertiaryLabel))
                .frame(width: size, height: size)
                .padding(lineWidth / 2)
        }
    }
}
