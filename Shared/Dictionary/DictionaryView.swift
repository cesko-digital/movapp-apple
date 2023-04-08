//
//  DictionaryView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct DictionaryView: View {

    @State private var searchString: String = ""
    @State private var selectedCategory: Dictionary.Category?

    let selectedLanguage: SetLanguage

    @EnvironmentObject var dataStore: DictionaryDataStore

    var body: some View {
        VStack(spacing: 0) {
            DictionaryHeaderView(searchString: $searchString)
                .onChange(of: selectedLanguage) { _ in
                    selectedCategory = nil
                }
                .onChange(of: searchString) { newValue in
                    // Search only in
                    // This forces header view to hide header
                    if newValue != "" && selectedCategory != nil {
                        selectedCategory = nil
                    }
                }

            if let dictionary = dataStore.dictionary {
                DictionaryContentView(
                    searchString: searchString,
                    language: selectedLanguage,
                    categories: dictionary.categories,
                    phrases: dictionary.phrases,
                    selectedCategory: $selectedCategory
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
        // Align middle
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

struct DictionaryView_Previews: PreviewProvider {
    static let dataStore = DictionaryDataStore()

    static var previews: some View {
        DictionaryView(selectedLanguage: .csUk)
            .environmentObject(dataStore)
    }
}
