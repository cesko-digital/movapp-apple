//
//  LanguageProvider.swift
//  MovappWatch Watch App
//
//  Created by Jakub Ruzicka on 16.04.2023.
//

import Foundation

final class LanguageProvider: ObservableObject {
    static var shared = LanguageProvider()

    @Published var language: SetLanguage?
}
