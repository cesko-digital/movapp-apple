//
//  AlphabetView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import Combine
import Introspect
import SwiftUI

struct AlphabetView<ViewModel: AlphabetViewModeling>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Group {
                switch viewModel.state {
                case .loading:
                    loadingView
                case .error(let message):
                    errorView(message: message)
                case .loaded(let content):
                    loadedContent(content: content)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("colors/item"))
        .onAppear(perform: viewModel.viewAppeared.send)
    }

    func loadedContent(content: [AlphabetContent]) -> some View {
        VStack (spacing: 0) {
            Picker("Select alphabet language", selection: $viewModel.selectedAlphabet) {
                ForEach(content.compactMap { $0.language }, id: \.rawValue) { language in
                    Text(LocalizedStringKey(language.alphabetTitle)).tag(language)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            .background(Color("colors/primary"))
            .introspectSegmentedControl { control in
                control.setTitleTextAttributes([.foregroundColor: UIColor(white: 1, alpha: 0.8)], for: .normal)

                control.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
            }

            TabView(selection: $viewModel.selectedAlphabet) {
                ForEach(Array(content.enumerated()), id: \.offset) { _, item in
                    ScrollViewReader { proxy in
                        ScrollView(showsIndicators: false) {
                            LazyVStack (spacing: 10) {
                                ForEach(item.alphabet.items, id: \.id) { item in
                                    AlphabetItemView(item: item, language: viewModel.selectedAlphabet)
                                }
                            }
                        }
                        .overlay {
                            // Based on https://www.fivestars.blog/articles/section-title-index-swiftui/
                            AlphabetShortcutsView(items: item.alphabet.cleanItems, proxy: proxy)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .tag(item.language)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }

    var loadingView: some View {
        ProgressView()
    }

    func errorView(message: String) -> some View {
        Text(message)
    }
}

struct AlphabetView_Previews: PreviewProvider {
    static let soundService = SoundService()

    class MockViewModel: AlphabetViewModeling {
        var state: AlphabetState
        var selectedAlphabet: Languages
        let viewAppeared = PassthroughSubject<Void, Never>()

        init(state: AlphabetState, selectedAlphabet: Languages) {
            self.state = state
            self.selectedAlphabet = selectedAlphabet
        }
    }
    
    static var previews: some View {
        AlphabetView(viewModel: MockViewModel(state: .loading, selectedAlphabet: .uk))
            .environmentObject(soundService)
        AlphabetView(viewModel: MockViewModel(state: .error("Not loaded content"), selectedAlphabet: .uk))
            .environmentObject(soundService)
        AlphabetView(viewModel: MockViewModel(state: .loaded([AlphabetContent(language: .uk, alphabet: .example), AlphabetContent(language: .cs, alphabet: .example)]), selectedAlphabet: .uk))
            .environmentObject(soundService)
    }
}
