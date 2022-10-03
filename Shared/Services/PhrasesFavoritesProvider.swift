//
//  PhrasesFavoritesProvider.swift
//  Movapp (iOS)
//
//  Created by Radek Pistelak on 14.04.2022.
//

import Foundation

/// Provides favorites prrases to the client.
///
/// Discussions:
///  - Why `ObservableObject`?
///     - It is injected to the views as `EnvironmentObject`
///  - When to use `PhraseFavoritesProvider` and when `PhraseFavoritesService`?
///     - Use service if you need to re-render your view on each change. Otherwise use provider.
final class PhrasesFavoritesProvider: ObservableObject {

    let favoritesService: PhraseFavoritesService

    init(favoritesService: PhraseFavoritesService) {
        self.favoritesService = favoritesService
    }

    func getFavorites(language: SetLanguage) -> [Dictionary.PhraseID] {
        favoritesService.getFavorites(language: language)
    }
}
