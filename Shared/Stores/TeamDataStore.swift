//
//  TeamDataStore.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.05.2022.
//

import SwiftUI

class TeamDataStore: ObservableObject {

    @Published var loading: Bool = false
    var team: Team?
    var error: String?

    func reload () {
        team = nil
        error = nil
        loading = false // Force reload data
    }

    func load() {
        if loading {
            return
        }

        loading = true

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            guard let asset = NSDataAsset(name: "data/team") else {
                error = "Invalid data file name"
                loading = false
                return
            }

            self.team = try decoder.decode(Team.self, from: asset.data)

        } catch {
            print(error)
            self.error = error.localizedDescription
        }

        loading = false
    }
}
