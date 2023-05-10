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

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                loadingState
            case .error:
                errorState
            case .won:
                wonState
            case .loaded(let content):
                pexeso(with: content)
            }
        }
    }

    private func pexeso(with content: [PexesoContent]) -> some View {
        VStack {
            newGameButton

            let numberOfColumns = Int(sqrt(Double(content.count)))
            let minimumWidth = CGFloat(UIScreen.main.bounds.width/CGFloat(numberOfColumns))
            let gridLayout: [GridItem] = Array(repeating: GridItem(.adaptive(minimum: minimumWidth)),
                                               count: numberOfColumns)

            LazyVGrid(columns: gridLayout, alignment: .center, spacing: 8) {
                ForEach(content) { item in
                    FlipView(content: item) { content in
                        viewModel.select(phrase: content)
                    }
                }
            }
        }
        .padding()
    }

    private var newGameButton: some View {
        Button("pexeso.new.game", action: viewModel.reset)
    }

    private var loadingState: some View {
        VStack {
            Text("Loading...")
        }
        .onAppear(perform: viewModel.viewAppeared.send)
    }

    private var wonState: some View {
        VStack {
            newGameButton

            Text("Won 🎉")
        }
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

        PexesoView(viewModel: MockViewModel(state: .won))
            .previewDisplayName("Won state")

        PexesoView(viewModel: MockViewModel(state: .error))
            .previewDisplayName("Error state")

        PexesoView(viewModel: MockViewModel(state:
                .loaded(content: Array(repeating: .init(imageName: "images/rec00jYJm8WGf61L3",
                                                        translation: examplePhrase.main,
                                                        selected: false,
                                                        found: false),
                                       count: 16))
        ))
    }
}
