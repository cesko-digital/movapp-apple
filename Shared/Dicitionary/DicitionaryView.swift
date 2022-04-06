//
//  DicitionaryView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI


struct DicitionaryView: View {
    @State private var searchString: String = ""
    @State private var selectedSection: Section? = nil
    @State private var selectedLanguage: SetLanguage = SetLanguage.csUk
    
    // TODO wrap to a struct object to track "one" event change?
    @State private var loaded: Bool?
    @State private var translations: Translations?
    @State private var sections: Sections?
    
    @EnvironmentObject var favoritesService: TranslationFavoritesService
    
    var body: some View {
        VStack (spacing: 0) {
            DictionaryHeaderView(searchString: $searchString, selectedLanguage: $selectedLanguage)
                .onChange(of: selectedLanguage) { [selectedLanguage] newLanguage in
                    
                    if newLanguage.language.filePrefix != selectedLanguage.language.filePrefix {
                        loaded = false
                        translations = nil
                        sections = nil
                        // TODO TEST, this code should force new load
                    }
                }
            
            if translations != nil && sections != nil {
                DictionaryContentView(
                    searchString: searchString,
                    language: selectedLanguage,
                    sections: sections!,
                    translations: translations!,
                    selectedSection: $selectedSection
                )
                
            } else {
                errorView
            }
        }
        #if canImport(UIKit)
        // Discard keyboard
        .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        #endif
        
       
    }
    
    var errorView: some View {
        // Allign middle
        VStack {
            Spacer()
            if (loaded != nil) {
                Text(
                    "Failed to load data",
                    comment: "When data has failed to load show this message"
                )
            } else {
                ProgressView().onAppear(perform: loadData)
            }
            Spacer()
        }
    }
    
    func loadData () {
        let decoder = JSONDecoder()
        
        let prefix = selectedLanguage.language.filePrefix
        
        // TODO background thread
        if let asset = NSDataAsset(name: "sections-" + prefix) {
            let data = asset.data
            
            sections = try? decoder.decode([Section].self, from: data)
        }
        
        if let asset = NSDataAsset(name: "translations-" + prefix) {
            let data = asset.data
            
            translations = try? decoder.decode(Translations.self, from: data)
            
            
            
            if translations != nil {
                let favoriteIds = favoritesService.getFavorites(language: selectedLanguage)
                
                for translationId in favoriteIds {
                    guard let translation = translations!.byId[translationId] else {
                        print("Favorite list has non-existing translation")
                        favoritesService.setIsFavorited(false, translationId: translationId, language: selectedLanguage)
                        continue
                    }
                    
                    translation.isFavorited = true
                    
                }
            }
        }
        
        loaded = true
    }
}

struct DicitionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DicitionaryView()
    }
}
