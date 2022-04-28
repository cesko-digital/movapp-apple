//
//  AlphabetView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI
import Introspect

struct AlphabetView: View {
    @EnvironmentObject var dataStore: AlphabetDataStore
    
    @State private var selectedLanguage: SetLanguage = .csUk
    
    var body: some View {
        VStack (spacing: 0) {
            Picker("Select alphabet language", selection: $selectedLanguage) {
                Text("Czech alphabet").tag(SetLanguage.csUk)
                Text("Ukraine alphabet").tag(SetLanguage.ukCs)
            }
            .pickerStyle(.segmented)
            .padding()
            .background(Color("colors/primary"))
            .introspectSegmentedControl { control in
                control.setTitleTextAttributes([.foregroundColor: UIColor(white: 1, alpha: 0.8)], for: .normal)
                
                control.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
            }
            
            if let alphabet = dataStore.alphabet {
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        LazyVStack (spacing: 10) {
                            ForEach(alphabet.items, id: \.id) { item in
                                AlphabetItemView(item: item, language: selectedLanguage.languagePrefix)
                            }
                        }
                    }
                    .overlay {
                        // Based on https://www.fivestars.blog/articles/section-title-index-swiftui/
                        AlphabetShortcutsView(items: alphabet.cleanItems, proxy: proxy)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            } else {
                errorOrLoadView
            }
            
            Spacer(minLength: 0)
        }
        .background(Color("colors/item"))
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
