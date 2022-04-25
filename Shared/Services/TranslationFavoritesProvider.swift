//
//  TranslationFavoritesProvider.swift
//  Movapp (iOS)
//
//  Created by Radek Pistelak on 14.04.2022.
//

import Foundation

/// Provides favorites translations to the client.
///
/// Discussions:
///  - Why `ObservableObject`?
///     - It is injected to the views as `EnvironmentObject`
///  - When to use `TranslationFavoritesProvider` and when `TranslationFavoritesService`?
///     - Use service if you need to re-render your view on each change. Otherwise use provider.
final class TranslationFavoritesProvider: ObservableObject {
    
    let favoritesService: TranslationFavoritesService
    
    init(favoritesService: TranslationFavoritesService) {
        self.favoritesService = favoritesService
    }
    
    func getFavorites(language: SetLanguage) -> [Dictionary.TranslationID] {
        favoritesService.getFavorites(language: language)
    }
}
