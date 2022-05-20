//
//  PhrasesView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct PhrasesView: View {
    
    var showPhrases: [Dictionary.Phrase]
    let language: SetLanguage
    
    init (
        language: SetLanguage,
        searchString: String,
        phrases: [Dictionary.Phrase],
        matchService: PhraseMatchService
    )
    {
        self.language = language
        
        if searchString.isEmpty {
            showPhrases = phrases
        } else {
            showPhrases = matchService.matchPhrases(phrases, searchString: searchString, language: language)
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(showPhrases)  { phrase in
                    PhraseView(
                        language: language,
                        phrase: phrase
                    )
                }
            }
            .padding()
            .background(Color("colors/background"))
        }
    }
}

struct PhrasesView_Previews: PreviewProvider {
    static let soundService = SoundService()
    static let userDefaultsStore = UserDefaultsStore()
    static let favoritesService = PhraseFavoritesService(userDefaultsStore: userDefaultsStore, dictionaryDataStore: DictionaryDataStore())
    static let matchService = PhraseMatchService(favoritesService: favoritesService)
    
    static var previews: some View {
        PhrasesView(
            language: .csUk,
            searchString: "",
            phrases: [
                examplePhrase,
            ],
            matchService: matchService
        )
        .environmentObject(soundService)
        .environmentObject(favoritesService)
        
        PhrasesView(
            language: .ukCs,
            searchString: "",
            phrases: [
                examplePhrase
            ],
            matchService: matchService
        )
        .environmentObject(soundService)
        .environmentObject(favoritesService)
    }
}
