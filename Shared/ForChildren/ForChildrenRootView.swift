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
            ScrollView {
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
            }
            .background(Color("colors/item"))
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
            NavigationLink {
                images
                    .navigationTitle("Obrázky")
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Obrázky")
                            .bold()
                            .foregroundColor(Color("colors/text"))
                    }
                    Spacer()
                }
                .padding()
                .background(.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("colors/inactive"))
                )
                .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
            }
            .padding()

            let gridLayout: [GridItem] = [GridItem(.adaptive(minimum: 375))]

            ForEach(content) { section in
                Text(LocalizedStringKey(stringLiteral: "stories.list.origin.\(section.title)"))
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top)
                LazyVGrid(columns: gridLayout, alignment: .center) {
                    ForEach(section.stories, id: \.self) { item in
                        ForChildrenRootStoryView(item: item,
                                                 selectedLanguage: languageStore.currentLanguage)
                    }
                }
            }
        }
        .padding(.bottom)
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
                                                .init(title: "CZ", stories: [.mock])
                                            ]
                                          )
                )
        )
            .previewDisplayName("With stories")
            .environmentObject(languageStore)
            .environmentObject(forChildrenDataStore)
    }
}
