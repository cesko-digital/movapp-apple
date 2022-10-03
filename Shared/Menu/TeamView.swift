//
//  TeamView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.05.2022.
//

import SwiftUI

struct TeamView: View {

    @EnvironmentObject var dataStore: TeamDataStore
    @EnvironmentObject var onBoardingDataStore: OnBoardingStore

    private let languageKey: String

    init(selectedLanguage: SetLanguage) {
        self.languageKey = selectedLanguage.language.main.rawValue
    }

    var body: some View {

        if let team = dataStore.team {
            List {
                ForEach(team.sections) { section in
                    Section {
                        ForEach(section.members) { member in
                            Text(member.name)
                        }
                    } header: {
                        Text(section.name[languageKey] ?? "Default value")
                    }
                }
            }

        } else {
            errorOrLoadView
        }
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
        dataStore.load()
    }
}

struct TeamView_Previews: PreviewProvider {
    static let dataStore = TeamDataStore()
    static let onBoardingStore = OnBoardingStore(userDefaultsStore: UserDefaultsStore())

    static var previews: some View {
        TeamView(selectedLanguage: .csUk)
            .environmentObject(dataStore)
            .environmentObject(onBoardingStore)
    }
}
