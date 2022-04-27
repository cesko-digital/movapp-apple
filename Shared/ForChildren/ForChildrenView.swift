//
//  ForChildrenView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct ForChildrenView: View {
    @EnvironmentObject var dataStore: ForChildrenDataStore
    
    let selectedLanguage: SetLanguage
    
    var body: some View {
        VStack {
            if let forKids = dataStore.forKids {
                    ScrollView {
                        LazyVStack (spacing: 10) {
                            ForEach(forKids) { item in
                                ForChildrenItemView(item: item, selectedLanguage: selectedLanguage)
                            }
                        }
                    }
            } else {
                errorOrLoadView
            }
        }
        
        .background(Color("colors/item"))
        .onAppear(perform: loadData)
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
        dataStore.load()
    }
}

struct ForChildrenView_Previews: PreviewProvider {
    static let dataStore = ForChildrenDataStore()
    
    static var previews: some View {
        ForChildrenView(selectedLanguage: .csUk)
            .environmentObject(dataStore)
    }
}
