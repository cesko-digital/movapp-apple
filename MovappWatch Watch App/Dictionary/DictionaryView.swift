//
//  DictionaryView.swift
//  WatchMovapp WatchKit Extension
//
//  Created by Daryna Polevyk on 22.04.2022.
//

import Combine
import SwiftUI

struct DictionaryView<ViewModel: DictionaryViewModeling>: View {

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
        }
        .onAppear(perform: viewModel.viewAppeared.send)
    }

    private func loadedContent(content: DictionaryContent) -> some View {
        ForEach(Array(content.categories.enumerated()), id: \.offset) { _, item in
            NavigationLink("\(item.name.main) - \(item.name.source)") {
                PhrasesView(phrases: item.phrases)
                    .navigationTitle("\(item.name.main) - \(item.name.source)")
            }
        }
    }

    private func categoryView(content: Dictionary.Category.Name) -> some View {
        VStack {
            Text(content.main)
            Text(content.source)
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

struct DictionaryView_Previews: PreviewProvider {

    class MockViewModel: DictionaryViewModeling {
        let state: DictionaryState
        let viewAppeared = PassthroughSubject<Void, Never>()

        init(state: DictionaryState) {
            self.state = state
        }
    }

    static var previews: some View {
        DictionaryView(viewModel: MockViewModel(state: .error))
            .previewDisplayName("Error")
        DictionaryView(viewModel: MockViewModel(state: .loading))
            .previewDisplayName("Loading")

        DictionaryView(viewModel: MockViewModel(state: .loaded(
            DictionaryContent(
                categories:
                    [
                        DictionaryCategory(name: exampleCategory.name,
                                           phrases: [examplePhrase])
                    ]
            )
        )))
        .previewDisplayName("Loaded")
    }
}
