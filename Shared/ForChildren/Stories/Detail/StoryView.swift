//
//  StoryView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 31.10.2022.
//

import Combine
import SwiftUI

struct StoryView<ViewModel: StoryViewModeling>: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                loading
            case .error(let message):
                error(message: message)
            case .loaded(let content):
                loaded(content: content)
            }
        }
    }

    var loading: some View {
        Text("Loading...")
            .onAppear(perform: viewModel.load)
    }

    func error(message: String) -> some View {
        Text("Error 😱: \(message)")
    }

    func loaded(content: StoryContent) -> some View {
        VStack(alignment: .center) {
            StoryHeadlineView(content: content.headline)

            PlayerView(content: content.player) { button in
                viewModel.buttonTapped.send(button)
            }

            Text("Loaded")
        }
        .frame(maxWidth: .infinity)
    }
}

struct StoryView_Previews: PreviewProvider {
    class MockViewModel: StoryViewModeling {
        let buttonTapped = PassthroughSubject<PlayerButton, Never>()
        var state: StoryState

        init(_ state: StoryState) {
            self.state = state
        }

        func load() { }
    }

    static var previews: some View {
        StoryView(viewModel: MockViewModel(.loading))
            .previewDisplayName("Loading")
    }
}
