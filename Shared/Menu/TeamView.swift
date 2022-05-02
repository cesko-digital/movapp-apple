//
//  TeamView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.05.2022.
//

import SwiftUI

struct TeamView: View {
    
    @EnvironmentObject var dataStore: TeamDataStore
    
    var body: some View {
        
        if let team = dataStore.team {
            List {
                ForEach(team.sections) { section in
                    Section {
                        ForEach(section.members) { member in
                            Text(member.name)
                        }
                    } header: {
                        Text(section.name)
                    }
                }
            }
            
        } else {
            errorOrLoadView
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
        dataStore.load()
    }
}

struct TeamView_Previews: PreviewProvider {
    static let dataStore = TeamDataStore()
    
    static var previews: some View {
        TeamView()
            .environmentObject(dataStore)
    }
}
