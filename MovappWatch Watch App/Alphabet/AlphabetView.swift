//
//  AlphabetView.swift
//  WatchMovapp WatchKit Extension
//
//  Created by Daryna Polevyk on 22.04.2022.
//

import Combine
import SwiftUI

struct AlphabetView<ViewModel: AlphabetViewModeling>: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            LazyVStack {
                Group {
                    switch viewModel.state {
                    case .loading:
                        loadingView
                    case .error:
                        errorView
                    case .loaded(let content):
                        loadedContent(content: content)
                    }
                }
            }
            .padding(8)
        }
        .onAppear(perform: viewModel.viewAppeared.send)
    }

    private func loadedContent(content: [AlphabetContent]) -> some View {
        ForEach(Array(content.enumerated()), id: \.offset) { _, item in
            NavigationLink(LocalizedStringKey(item.language.alphabetTitle)) {
                AlphabetDetailView(content: item.alphabet)
                    .navigationTitle(LocalizedStringKey(item.language.alphabetTitle))
            }
        }
    }

    private var loadingView: some View {
        ProgressView()
    }

    private var errorView: some View {
        Text("Something went wrong, sorry 😢")
            .multilineTextAlignment(.center)
    }
}

struct AlphabetView_Previews: PreviewProvider {

    class MockViewModel: AlphabetViewModeling {
        let state: AlphabetState
        let viewAppeared = PassthroughSubject<Void, Never>()

        init(state: AlphabetState) {
            self.state = state
        }
    }

    static var previews: some View {
        AlphabetView(viewModel: MockViewModel(state: .error))
            .previewDisplayName("Error")
        AlphabetView(viewModel: MockViewModel(state: .loading))
            .previewDisplayName("Loading")

        AlphabetView(viewModel: MockViewModel(state: .loaded(
            [
                AlphabetContent(language: .cs, alphabet: .example),
                AlphabetContent(language: .uk, alphabet: .example)
            ]
        )))
        .previewDisplayName("Loaded")
    }
}
