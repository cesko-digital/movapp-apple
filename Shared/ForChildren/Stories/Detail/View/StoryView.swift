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
                .padding(.horizontal, 32)
                .padding(.vertical, 12)

            PlayerView(content: content.player) { button in
                viewModel.buttonTapped.send(button)
            }
            .padding(.horizontal, 32)

            ScrollView {
                ScrollViewReader { reader in
                    LazyVStack(alignment: .leading, spacing: 24) {
                        let indexOfCurrent = content.story.sentences.firstIndex(where: { $0.isCurrent })
                        ForEach(Array(content.story.sentences.enumerated()), id: \.offset) { index, item in
                            Text(item.text)
                                .foregroundColor(getColorFor(index: index, current: indexOfCurrent))
                                .fontWeight(.bold)
                                .lineLimit(nil)
                                .font(.body)
                                .id(index)
                        }
                        .onChange(of: content.story) { _ in
                            if let currentItem = content.story.sentences.firstIndex(where: { $0.isCurrent }) {
                                reader.scrollTo(currentItem, anchor: .center)
                            }
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color("colors/primary"))
        }
        .padding(.bottom, 1)
        .frame(maxWidth: .infinity)
        .onDisappear {
            viewModel.buttonTapped.send(.pause)
        }
    }

    private func getColorFor(index: Int, current: Int?) -> Color {
        guard let current = current else {
            return .white
        }

        if index == current {
            return Color("colors/yellow")
        }

        if index < current {
            return .white.opacity(0.5)
        }

        return .white
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

        StoryView(viewModel: MockViewModel(
            .loaded(content:
                    .init(headline: .init(image: "images/cervena-karkulka",
                                          title: "O perníkové chaloupce",
                                          subtitle: "Прянична хатинка"),
                          player: .init(timer: .init(currentTime: 0, maxTime: 180),
                                        state: .paused,
                                        languages: (.cs, .uk)),
                          story: .init(sentences: [
                            .init(text: "Жили вони в хатинці посеред лісу.",
                                  isCurrent: false,
                                  start: 1,
                                  end: 2),
                            .init(text: "Zatímco kácel stromy, děti si v lese hrály a mlsaly lesní jahody a borůvky.",
                                  isCurrent: true,
                                  start: 2,
                                  end: 3),
                            .init(text: "Jednoho dne se zatoulaly příliš daleko a nemohly najít cestu domů.",
                                  isCurrent: false,
                                  start: 3,
                                  end: 4)
                          ])
                    ))))
        .previewDisplayName("Loaded")
    }
}
