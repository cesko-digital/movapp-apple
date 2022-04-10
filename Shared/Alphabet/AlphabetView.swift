//
//  AlphabetView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI


struct AlphabetView: View {
    @EnvironmentObject var dataStore: AlphabetDataStore
    
    @State private var selectedLanguage: SetLanguage = .csUk
    
    var body: some View {
        VStack (spacing: 0) {
            Picker("Select view", selection: $selectedLanguage) {
                Text("Česká abeceda").tag(SetLanguage.csUk)
                Text("Ukrajinská abeceda").tag(SetLanguage.ukCs)
            }
            .pickerStyle(.segmented)
            .padding()
            
            if let alphabet = dataStore.alphabet {
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        LazyVStack (spacing: 10) {
                            ForEach(alphabet.data, id: \.id) { item in
                                AlphabetItemView(item: item, language: alphabet.language)
                            }
                        }
                    }
                    .overlay {
                        // Based on https://www.fivestars.blog/articles/section-title-index-swiftui/
                        AlphabetShortcutsView(items: dataStore.alphabet!.data, proxy: proxy)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            } else {
                errorOrLoadView
            }
            
            Spacer(minLength: 0)
        }
        .onChange(of: selectedLanguage) { _ in
            dataStore.reset()
        }
    }
    
    var errorOrLoadView: some View {
        // Allign middle
        VStack {
            Spacer()
            if let error = dataStore.error {
                Text(error)
            } else {
                ProgressView().onAppear(perform: loadData)
            }
            Spacer()
        }
    }
    
    func loadData() {
        dataStore.load(language: selectedLanguage)
    }
}

struct AlphabetView_Previews: PreviewProvider {
    static let dataStore = AlphabetDataStore()
    static let soundService = SoundService()
    
    static var previews: some View {
        AlphabetView()
            .environmentObject(dataStore)
            .environmentObject(soundService)
    }
}
