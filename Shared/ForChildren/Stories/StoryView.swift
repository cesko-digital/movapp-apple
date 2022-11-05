//
//  StoryView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 31.10.2022.
//

import SwiftUI

struct StoryView<ViewModel: StoryViewModeling>: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                loading
            case .loaded(let content):
                loaded(content: content)
            }
        }
    }

    var loading: some View {
        Text("Loading...")
            .onAppear(perform: viewModel.load)
    }

    func loaded(content: StoryContent) -> some View {
        Text("Loaded")
    }
}

struct StoryView_Previews: PreviewProvider {
    class MockViewModel: StoryViewModeling {
        var state: StoryState

        init(_ state: StoryState) {
            self.state = state
        }

        func load() { }
    }

    static var previews: some View {
        StoryView(viewModel: MockViewModel(.loading))
            .previewDisplayName("Loading")

        StoryView(viewModel: MockViewModel(.loaded(content: .init())))
            .previewDisplayName("Loaded")
    }
}
