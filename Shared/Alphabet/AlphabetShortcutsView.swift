//
//  AlphabetShortcutsView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 10.04.2022.
//

import SwiftUI

struct AlphabetShortcutsView: View {
    let items: [AlphabetItem]
    let proxy: ScrollViewProxy
    
    @GestureState private var dragLocation: CGPoint = .zero
    
    let impactMed = UIImpactFeedbackGenerator(style: .light)
    @State var lastScroll: String?
    
    var body: some View {
        VStack {
            ForEach(items, id: \.id) { item in
                Text(item.letters.first!!)
                    .padding(.trailing, 2)
                    .padding(.leading, 4)
                    .font(.system(size: 11).bold())
                    .foregroundColor(.accentColor)
                    .background(dragObserver(item: item))
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .updating($dragLocation) { value, state, _ in
                    state = value.location
                }
        )
    }
    
    func scrollTo (_ item: AlphabetItem) {
        // We can receive the event multiple times on the same "id"
        guard lastScroll != item.id else  {
            return
        }
        
        impactMed.impactOccurred()
        
        proxy.scrollTo(item.id, anchor: .top)
        
        lastScroll = item.id
    }
    
    func dragObserver(item: AlphabetItem) -> some View {
        GeometryReader { geometry in
            dragObserver(geometry: geometry, item: item)
        }
    }
    
    // This function is needed as view builders don't allow to have
    // pure logic in their body.
    private func dragObserver(geometry: GeometryProxy, item: AlphabetItem) -> some View {
        if geometry.frame(in: .global).contains(dragLocation) {
            // we need to dispatch to the main queue because we cannot access to the
            // `ScrollViewProxy` instance while the body is rendering
            DispatchQueue.main.async {
                scrollTo(item)
            }
        }
        return Rectangle().fill(Color.clear)
    }
    
    
}
