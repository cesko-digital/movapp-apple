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
    
    let selectedLanguage: SetLanguage
    
    @State private var selectedAlphabet: Languages
    
    let languages: [Languages]
    
    init (selectedLanguage: SetLanguage) {
        self.selectedLanguage = selectedLanguage
        
        let languagesList = [
            selectedLanguage.language.main,
            selectedLanguage.language.source
        ]
        
        // Always show the alphabet of a language im learning
        languages = selectedLanguage.flipFromWithTo ? languagesList : languagesList.reversed()
        
        selectedAlphabet = languages.first!
    }
    
    var body: some View {
        VStack (spacing: 0) {
            Picker("Select alphabet language", selection: $selectedAlphabet) {
                ForEach(languages, id: \.rawValue) { language in
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
            
            if let alphabet = dataStore.alphabet {
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        LazyVStack (spacing: 10) {
                            ForEach(alphabet.items, id: \.id) { item in
                                AlphabetItemView(item: item, language: selectedAlphabet)
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
        .onChange(of: selectedAlphabet) { _ in
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
        dataStore.load(language: selectedLanguage, alphabet: selectedAlphabet)
    }
}

struct AlphabetView_Previews: PreviewProvider {
    static let dataStore = AlphabetDataStore()
    static let soundService = SoundService()
    
    static var previews: some View {
        AlphabetView(selectedLanguage: .csUk)
            .environmentObject(dataStore)
            .environmentObject(soundService)
    }
}
