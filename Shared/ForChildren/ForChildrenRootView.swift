//
//  ForChildrenRootView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 27.10.2022.
//

import SwiftUI

struct ForChildrenRootView<ViewModel: ForChildrenRootViewModeling>: View {

    @StateObject var viewModel: ViewModel
    @EnvironmentObject var languageStore: LanguageStore

    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    loading
                case .imagesOnly:
                    images
                case .imagesWithStories(let content):
                    imagesWithStories(content: content)
                }
            }
            .navigationTitle(RootItems.for_children.title)
        }
    }

    var images: some View {
        ForChildrenView(selectedLanguage: languageStore.currentLanguage)
    }

    var loading: some View {
        // Align middle
        VStack {
            Spacer()
            ProgressView().onAppear(perform: viewModel.load)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    func imagesWithStories(content: [ForChildrenRootStoriesSection]) -> some View {
        VStack(alignment: .leading) {
            // TODO: Localization and styling
            NavigationLink {
                images
                    .navigationTitle("Obrázky")
            } label: {
                Text("Obrázky")
            }

            let gridLayout: [GridItem] = [GridItem(.adaptive(minimum: 375))]

            // TODO: Finish the card
            ForEach(content) { section in
                Text(section.title)
                LazyVGrid(columns: gridLayout, alignment: .center) {
                    ForEach(section.stories) { item in
                        CardView {
                            Content {
                                Text(item.title)
                            }
                            Footer {
                                Text(item.title)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ForChildrenRootView_Previews: PreviewProvider {
    static let userDefaultsStore = UserDefaultsStore()
    static let dictionaryDataStore = DictionaryDataStore()
    static let forChildrenDataStore = ForChildrenDataStore(dictionaryDataStore: dictionaryDataStore)
    static let languageStore = LanguageStore(userDefaultsStore: userDefaultsStore,
                                             dictionaryDataStore: dictionaryDataStore,
                                             forChildrenDataStore: forChildrenDataStore)

    class MockViewModel: ForChildrenRootViewModeling {
        var state: ForChildrenRootState

        func load() { }

        init(state: ForChildrenRootState) {
            self.state = state
        }
    }

    static var previews: some View {
        ForChildrenRootView(viewModel: MockViewModel(state: .loading))
            .previewDisplayName("Loading state")
            .environmentObject(languageStore)
            .environmentObject(forChildrenDataStore)

        ForChildrenRootView(viewModel: MockViewModel(state: .imagesOnly))
            .previewDisplayName("Images only")
            .environmentObject(languageStore)
            .environmentObject(forChildrenDataStore)

        ForChildrenRootView(
            viewModel:
                MockViewModel(state:
                        .imagesWithStories(content:
                                            [
                                                .init(
                                                    title: "České",
                                                    stories: [
                                                        .init(
                                                            title: "Title",
                                                            image: "image",
                                                            duration: "3 min"
                                                        )
                                                    ]
                                                )
                                            ]
                                          )
                )
        )
            .previewDisplayName("With stories")
            .environmentObject(languageStore)
            .environmentObject(forChildrenDataStore)
    }
}
