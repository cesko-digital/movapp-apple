//
//  StoriesListView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 12.11.2022.
//

import Combine
import SwiftUI

struct StoriesListView<ViewModel: StoriesListViewModeling>: View {

    @StateObject var viewModel: ViewModel
    @EnvironmentObject var languageStore: LanguageStore

    var body: some View {
        ScrollView {
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
        .frame(maxWidth: .infinity)
        .background(Color("colors/item"))
    }

    var loading: some View {
        ProgressView()
            .onAppear { viewModel.viewAppeared.send() }
    }

    func error(message: String) -> some View {
        Text("Error 😱: \(message)")
    }

    func loaded(content: [StoriesSection]) -> some View {
        ForEach(content) { section in
            Text(LocalizedStringKey(stringLiteral: "stories.list.origin.\(section.title)"))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.top)
                .foregroundColor(Color("colors/primary"))
            LazyVStack {
                ForEach(section.stories, id: \.self) { item in
                    StoriesListItemView(item: item,
                                        selectedLanguage: languageStore.currentLanguage)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}

struct StoriesListView_Previews: PreviewProvider {
    static let userDefaultsStore = UserDefaultsStore()
    static let dictionaryDataStore = DictionaryDataStore()
    static let forChildrenDataStore = ForChildrenDataStore(dictionaryDataStore: dictionaryDataStore)
    static let languageStore = LanguageStore(userDefaultsStore: userDefaultsStore,
                                             dictionaryDataStore: dictionaryDataStore,
                                             forChildrenDataStore: forChildrenDataStore)

    class MockViewModel: StoriesListViewModeling {
        var state: StoriesState
        let viewAppeared = PassthroughSubject<Void, Never>()

        init(state: StoriesState) {
            self.state = state
        }
    }

    static var previews: some View {
        StoriesListView(viewModel: MockViewModel(state: .loading))
            .previewDisplayName("Loading...")
            .environmentObject(languageStore)

        StoriesListView(viewModel: MockViewModel(state: .error(message: "This is error")))
            .previewDisplayName("Error")
            .environmentObject(languageStore)

        StoriesListView(viewModel: MockViewModel(state: .loaded(content: [
            .init(title: "CZ", stories: [.mock(), .mock(), .mock()]),
            .init(title: "UK", stories: [.mock(), .mock(), .mock()])
        ])))
            .previewDisplayName("Loaded content")
            .environmentObject(languageStore)
    }
}
