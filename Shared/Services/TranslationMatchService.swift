//
//  MatchService.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 05.04.2022.
//

import Foundation

struct TranslationWithDistance {
    let translation: Translation
    let distance: Int
}

enum TranslationMatchService {
    
    static func getMatchDistance(
        searchString: String,
        strings: [String]
    ) -> Int {
        var distances : [Int] = []
        for string in strings {
            if string.localizedCaseInsensitiveContains(searchString) {
                     
                //let distance = Levenshtein.distance(between: searchString, and: string)
                let distance = searchString.levenshteinDistance(with: string, caseSensitive: false, diacriticSensitive: false)
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
    static func matchTranslations(_ translations: [Translation], searchString: String) -> [Translation] {
        
        let start = CFAbsoluteTimeGetCurrent()
        
        var translationWithDistances: [TranslationWithDistance] = []
        
        for translation in translations {
            let distance = getMatchDistance(searchString: searchString, strings: [
                translation.translationFrom,
                translation.transcriptionFrom,
                translation.transcriptionTo,
                translation.translationTo
            ])
            
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
