//
//  MatchService.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 05.04.2022.
//

import Foundation

struct TranslationWithDistance {
    let translation: Dictionary.Translation
    let distance: Int
}

enum TranslationMatchService {
    
    static func getMatchDistance(
        searchString: String,
        strings: [String],
        languagePrefix: String
    ) -> Int {
        var distances : [Int] = []
        let locale = Locale(identifier: languagePrefix)
        let cleanSearchString = searchString.lowercased().folding(options: .diacriticInsensitive, locale: locale)
        
        for string in strings {
            let cleanString = string.lowercased().folding(options: .diacriticInsensitive, locale: locale)
            
            if cleanString.contains(cleanSearchString) {
                let distance = searchString.levenshteinDistance(with: string, caseSensitive: true, diacriticSensitive: true)
                distances.append(distance)
            }
        }
        
        if distances.count == 0 {
            return 0
        }
        
        return distances.min()!
    }
    
    /**
     Returns translations that contains given string in all translations (all languages) and sorts by levenshtein distance.
     */
    static func matchTranslations(_ translations: [Dictionary.Translation], searchString: String, language: SetLanguage) -> [Dictionary.Translation] {
        
        let start = CFAbsoluteTimeGetCurrent()
        
        var translationWithDistances: [TranslationWithDistance] = []
        
        let languagePrefix = language.languagePrefix.rawValue
        
        for translation in translations {
            
            let source = [
                translation.translationFrom,
                translation.translationTo
            ]
            // TODO:
            // First rank - favorite
            // Second rank - exact word match
            // Third rank - match distance
            
            let distance = getMatchDistance(searchString: searchString, strings: source, languagePrefix: languagePrefix)
            
            guard distance != 0 else {
                continue
            }
            
            let translationWithDistance = TranslationWithDistance(translation: translation, distance: distance)
            translationWithDistances.append(translationWithDistance)
        }
        
        let result = translationWithDistances.sorted { t1, t2 in
            return t1.distance < t2.distance;
        }.map({ translation in
            translation.translation
        })
        
        let diff = CFAbsoluteTimeGetCurrent() - start
        print("Translation match took \(diff) seconds with \(result.count) results")
        
        return result
    }
}
