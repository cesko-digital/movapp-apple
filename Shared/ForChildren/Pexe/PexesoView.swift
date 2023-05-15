//
//  PexesoView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 17.10.2022.
//

import Combine
import SwiftUI

struct PexesoView<ViewModel: PexesoViewModeling>: View {
    @StateObject var viewModel: ViewModel
    @State private var isWon: Bool = false

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                loadingState
            case .error:
                errorState
            case .won(let content):
                wonState(with: content)
            case .loaded(let content):
                pexeso(with: content)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("colors/item"))
    }

    private func pexeso(with content: [PexesoContent]) -> some View {
        VStack {
            newGameButton

            GeometryReader { geometry in
                let numberOfColumns = Int(sqrt(Double(content.count)))
                let smallerSide = min(geometry.size.width, geometry.size.height)
                // Cell width without spacing
                let cellWidth = (smallerSide - (CGFloat(numberOfColumns-1)) * 8) / CGFloat(numberOfColumns)
                let gridLayout: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 0, maximum: cellWidth)),
                                                   count: numberOfColumns)

                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 8) {
                    ForEach(content) { item in
                        FlipView(content: item) { content in
                            viewModel.select(phrase: content)
                        }
                        .frame(minWidth: cellWidth, minHeight: cellWidth)
                    }
                }
            }
        }
        .padding()
    }

    private var newGameButton: some View {
        Button("pexeso.new.game", action: viewModel.reset)
            .buttonStyle(.borderedProminent)
            .tint(Color("colors/primary"))
            .padding(.bottom, 16)
    }

    private var loadingState: some View {
        VStack {
            Text("Loading...")
        }
        .onAppear(perform: viewModel.viewAppeared.send)
    }

    private func wonState(with content: [PexesoContent]) -> some View {
        VStack {
            newGameButton

            GeometryReader { geometry in
                let numberOfColumns = Int(sqrt(Double(content.count)))
                let smallerSide = min(geometry.size.width, geometry.size.height)
                // Cell width without spacing
                let cellWidth = (smallerSide - (CGFloat(numberOfColumns-1)) * 8) / CGFloat(numberOfColumns)
                let gridLayout: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 0, maximum: cellWidth)),
                                                   count: numberOfColumns)

                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 8) {
                    ForEach(content) { item in
                        FlipView(content: item) { _ in }
                            .border(.conicGradient(colors: [.green, .red, .cyan, .orange], center: .center))
                            .rotationEffect(Angle(degrees: isWon ? 360 : 0), anchor: .center)
                    }
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.5).repeatCount(4)) {
                isWon.toggle()
            }
        }
        .padding()
    }

    private var errorState: some View {
        VStack {
            Text("Error")
        }
    }
}

struct PexesoView_Previews: PreviewProvider {

    class MockViewModel: PexesoViewModeling {
        let viewAppeared = PassthroughSubject<Void, Never>()
        var state: PexesoState

        init(state: PexesoState) {
            self.state = state
        }

        func reset() { }
        func select(phrase: PexesoContent) { }
    }

    static var previews: some View {
        PexesoView(viewModel: MockViewModel(state: .loading))
            .previewDisplayName("Loading state")

        PexesoView(viewModel: MockViewModel(state:
                .won(content: (0...15).map { _ in
                        .init(imageName: "\(UUID())",
                              translation: examplePhrase.main,
                              selected: true,
                              found: true)

                })
        ))
            .previewDisplayName("Won state")

        PexesoView(viewModel: MockViewModel(state: .error))
            .previewDisplayName("Error state")

        PexesoView(viewModel: MockViewModel(state:
                .loaded(content: (0...15).map { _ in
                        .init(imageName: "\(UUID())",
                              translation: examplePhrase.main,
                              selected: false,
                              found: false)
                })
        ))
        .previewDisplayName("Initial state")
    }
}
