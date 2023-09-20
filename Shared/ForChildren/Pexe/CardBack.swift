//
//  CardBack.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 19.10.2022.
//

import SwiftUI

struct CardBack: View {

    var body: some View {
        GeometryReader { geometry in

            let startPoint = CGPoint(x: 0, y: 0)
            let topMiddlePoint = CGPoint(x: (geometry.size.width * (2 / 3)), y: 0)
            let topEndPoint = CGPoint(x: geometry.size.width, y: 0)
            let bottomEndPoint = CGPoint(x: geometry.size.width, y: geometry.size.height)
            let bottomMiddlePoint = CGPoint(x: (geometry.size.width * (1 / 3)), y: geometry.size.height)
            let bottomStartPoint = CGPoint(x: 0, y: geometry.size.height)

            Path { path in
                path.move(to: startPoint)
                path.addLine(to: topMiddlePoint)
                path.addLine(to: bottomMiddlePoint)
                path.addLine(to: bottomStartPoint)
                path.addLine(to: startPoint)
                path.closeSubpath()
            }
            .fill(Color("colors/primary"))
            .cornerRadius(8)

            Path { path in
                path.move(to: topMiddlePoint)
                path.addLine(to: topEndPoint)
                path.addLine(to: bottomEndPoint)
                path.addLine(to: bottomMiddlePoint)
                path.addLine(to: topMiddlePoint)
                path.closeSubpath()
            }
            .fill(Color("colors/yellow"))
            .cornerRadius(8)
        }
        .shadow(color: .gray, radius: 2, x: 0, y: 0)
    }
}

struct CardBack_Previews: PreviewProvider {
    static var previews: some View {
        CardBack()
    }
}
