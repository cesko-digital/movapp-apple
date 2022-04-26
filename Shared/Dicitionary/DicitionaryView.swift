//
//  DicitionaryView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI


struct DicitionaryView: View {
    
    @State private var searchString: String = ""
    @State private var selectedSection: Dictionary.Section? = nil
    
    let selectedLanguage: SetLanguage
    
    @EnvironmentObject var dataStore: DictionaryDataStore
    
    var body: some View {
        VStack (spacing: 0) {
            DictionaryHeaderView(searchString: $searchString)
            
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
        dataStore.load(language: selectedLanguage)
    }
}

struct DicitionaryView_Previews: PreviewProvider {
    static let dataStore = DictionaryDataStore()
    
    static var previews: some View {
        DicitionaryView(selectedLanguage: .csUk)
            .environmentObject(dataStore)
    }
}
