//
//  CardView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 12.04.2022.
//

import SwiftUI

typealias Content<V> = Group<V> where V:View
typealias Footer<V> = Group<V> where V:View

struct CardView<V1, V2>: View where V1: View, V2: View {
    private let spacing: CGFloat
    private let content: () -> TupleView<(Content<V1>, Footer<V2>)>
    
    init(@ViewBuilder _ content: @escaping () -> TupleView<(Content<V1>, Footer<V2>)>, spacing: CGFloat = 20.0) {
        self.content = content
        self.spacing = spacing
    }
    
    var body: some View {
        let (content, footer) = self.content().value
        
        VStack (spacing: spacing) {
            content
            
            VStack {
                footer
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color("colors/yellow"))
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.04), radius: 38, x: 0, y: 19)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.04), radius: 12, x: 0, y: 15)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView {
            Content {
                Text("Content")
            }
            Footer {
                Text("Footer")
            }
        }
        
    }
}
