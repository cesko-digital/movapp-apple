//
//  ForChildrenView.swift
//  WatchMovapp WatchKit Extension
//
//  Created by Daryna Polevyk on 22.04.2022.
//

import Combine
import SwiftUI

struct ForChildrenView<ViewModel: ForChildrenViewModeling>: View {
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

    private func loadedContent(content: ForChildrenContent) -> some View {
        ForEach(Array(content.phrases.enumerated()), id: \.offset) { offset, item in
            VStack(alignment: .leading, spacing: 4) {
                if let imageName = item.imageName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(Color.white)
                }
                Text(item.main.translation)
                Text("[\(item.main.transcription)]")
                    .foregroundColor(.secondary)
                Spacer()
                Text(item.source.translation)
                Text("[\(item.source.transcription)]")
                    .foregroundColor(.secondary)

                if offset < content.phrases.count - 1 {
                    Divider()
                }
            }
            .padding(8)
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

struct ForChildrenView_Previews: PreviewProvider {
    class MockViewModel: ForChildrenViewModeling {
        let state: ForChildrenState
        let viewAppeared = PassthroughSubject<Void, Never>()

        init(state: ForChildrenState) {
            self.state = state
        }
    }

    static var previews: some View {
        ForChildrenView(viewModel: MockViewModel(state: .error))
            .previewDisplayName("Error")
        ForChildrenView(viewModel: MockViewModel(state: .loading))
            .previewDisplayName("Loading")

        ForChildrenView(viewModel: MockViewModel(state: .loaded(
            ForChildrenContent(phrases: [
                examplePhrase,
                examplePhrase
            ])
        )))
        .previewDisplayName("Loaded")
    }
}
