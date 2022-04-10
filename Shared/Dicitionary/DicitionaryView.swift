//
//  DicitionaryView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI


struct DicitionaryView: View {
    
    @State private var searchString: String = ""
    @State private var selectedSection: DictionarySection? = nil
    @State private var selectedLanguage: SetLanguage = .csUk
    
    @EnvironmentObject var dataStore: DictionaryDataStore
    @EnvironmentObject var favoritesService: TranslationFavoritesService
    
    var body: some View {
        VStack (spacing: 0) {
            DictionaryHeaderView(searchString: $searchString, selectedLanguage: $selectedLanguage)
                .onChange(of: selectedLanguage) { [selectedLanguage] newLanguage in
                    
                    if newLanguage.language.dictionaryFilePrefix != selectedLanguage.language.dictionaryFilePrefix {
                        dataStore.reload()
                        // TODO TEST, this code should force new load
                    }
                }
            
            if let dictionary = dataStore.dictionary {
                DictionaryContentView(
                    searchString: searchString,
                    language: selectedLanguage,
                    sections: dictionary.sections,
                    translations: dictionary.translations,
                    selectedSection: $selectedSection
                )
                
            } else {
                errorOrLoadView
            }
        }
        #if canImport(UIKit)
        // Discard keyboard
        .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        #endif
        
       
    }
    
    var errorOrLoadView: some View {
        // Allign middle
        VStack {
            Spacer()
            if let error = dataStore.error{
                Text(error)
            } else {
                ProgressView().onAppear(perform: loadData)
            }
            Spacer()
        }
    }
    
    func loadData() {
        dataStore.load(language: selectedLanguage, favoritesService: favoritesService)
    }
}

struct DicitionaryView_Previews: PreviewProvider {
    static let dataStore = DictionaryDataStore()
    
    static var previews: some View {
        DicitionaryView()
            .environmentObject(dataStore)
    }
}
