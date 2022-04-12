//
//  ForChildrenView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct ForChildrenView: View {
    @EnvironmentObject var dataStore: ForKidsDataStore
    
    var body: some View {
        VStack {
            if let forKids = dataStore.forKids {
              //  ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        LazyVStack (spacing: 10) {
                            ForEach(forKids) { item in
                                ForChildrenItemView(item: item)
                            }
                        }
                    }
              //  }
            } else {
                errorOrLoadView
            }
        }.onAppear(perform: loadData)
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
    static let dataStore = ForKidsDataStore()
    
    static var previews: some View {
        ForChildrenView()
            .environmentObject(dataStore)
    }
}
