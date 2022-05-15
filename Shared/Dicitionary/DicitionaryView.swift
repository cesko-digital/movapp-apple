//
//  DicitionaryView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI


struct DicitionaryView: View {
    
    @State private var searchString: String = ""
    @State private var selectedSection: Dictionary.Category? = nil
    
    let selectedLanguage: SetLanguage
    
    @EnvironmentObject var dataStore: DictionaryDataStore
    
    var body: some View {
        VStack (spacing: 0) {
            DictionaryHeaderView(searchString: $searchString)
                .onChange(of: searchString) { newValue in
                    // Search only in
                    // This forces header view to hide header
                    if newValue != "" && selectedSection != nil {
                        selectedSection = nil
                    }
                }
            
            if let dictionary = dataStore.dictionary {
                DictionaryContentView(
                    searchString: searchString,
                    language: selectedLanguage,
                    sections: dictionary.categories,
                    translations: dictionary.phrases,
                    selectedSection: $selectedSection
                )
                
            } else {
                errorOrLoadView
            }
        }
#if canImport(UIKit)
        // Discard keyboard
        .simultaneousGesture(DragGesture().onChanged { gesture in
            let forcing = false
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            keyWindow?.endEditing(forcing)
        })
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
