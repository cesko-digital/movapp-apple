//
//  MatchService.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 05.04.2022.
//

import Foundation

struct MatchedPhrase {
    let translation: Dictionary.Phrase
    let distance: Int
}

struct PhraseMatchService {
    let favoritesService: PhraseFavoritesService

    func containsExact(_ findString: String, _ inString: String) -> Bool {
        let expression = "\\b\(findString)\\b"
        return inString.range(of: expression, options: .regularExpression) != nil
    }

    func calculateScore (string: String, cleanSearchString: String, locale: Locale) -> Int {
        let cleanString = string
            .lowercased()
            .folding(options: .diacriticInsensitive, locale: locale)
            .replacingOccurrences(of: ".!", with: "")

        if containsExact(cleanSearchString, cleanString) {
            return 1
        }

        // Increase default levenshtein distance by 10 to make exact match on top
        if cleanString.contains(cleanSearchString) {
            let score = cleanSearchString.levenshteinDistance(with: string,
                                                              caseSensitive: true,
                                                              diacriticSensitive: true)

            // Increase by 10 to make it last
            return score > 0 ? score + 10 : 0
        }

        return 0
    }

    func getLowestScore(
        searchString: String,
        strings: [String],
        languagePrefix: String
    ) -> Int {
        var scores: [Int] = []
        let locale = Locale(identifier: languagePrefix)
        let cleanSearchString = searchString.lowercased().folding(options: .diacriticInsensitive, locale: locale)

        for string in strings {
            let score = calculateScore(string: string, cleanSearchString: cleanSearchString, locale: locale)

            if score > 0 {
                scores.append(score)
            }
        }

        return scores.min() ?? 0
    }

    /**
     Returns phases that contains given string in all phases (all languages) and sorts by levenshtein distance.
     */
    func matchPhrases(
        _ phrases: [Dictionary.Phrase],
        searchString: String,
        language: SetLanguage
    ) -> [Dictionary.Phrase] {

        let start = CFAbsoluteTimeGetCurrent()

        var matchedPhrases: [MatchedPhrase] = []

        let languagePrefix = language.languagePrefix.rawValue

        for phrase in phrases {
            let source = [
                phrase.main.translation,
                phrase.source.translation
            ]

            // First rank - exact word match
            // Second rank - favorite
            // Third rank - match distance

            let score = getLowestScore(searchString: searchString, strings: source, languagePrefix: languagePrefix)

            guard score != 0 else {
                continue
            }

            let scores = [
                favoritesService.isFavorited(phrase, language: language) ? 1 : 10,
                score
            ]

            let matchedPhrase = MatchedPhrase(translation: phrase, distance: scores.reduce(.zero, { $0 + $1 }))
            matchedPhrases.append(matchedPhrase)
        }

        let result = matchedPhrases.sorted { t1, t2 in
            return t1.distance < t2.distance
        }.map({ phrase in
            phrase.translation
        })

        let diff = CFAbsoluteTimeGetCurrent() - start
        print("Translation match took \(diff) seconds with \(result.count) results")

        return result
    }
}
