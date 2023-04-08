//
//  String+Levenshtein.swift
//  Levenshtein
//
//  Created by Cyril Chandelier on 01/07/15.
//  Copyright (c) 2015 Cyril Chandelier. All rights reserved.
//  https://github.com/cyrilchandelier/String-Levenshtein/blob/master/LICENSE
//
import Foundation

extension String {

    /**
     Inner class representing a two dimension array with subscript access to contained values
     */
    private class Array2D {
        var rows: Int
        var columns: Int
        var matrix: [Int]

        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            self.matrix = Array(repeating: 0, count: rows * columns)
        }

        subscript(row: Int, column: Int) -> Int {
            get {
                return matrix[row * columns + column]
            }
            set {
                matrix[row * columns + column] = newValue
            }
        }
    }

    /**
     Compute levenshtein distance between self and given String objects
     
     - parameter anotherString: A String object to compute the distance with
     - parameter caseSensitive: Weither or not the comparison should be case sensiste
     
     - returns: An Int representing levenshtein distance, the higher this number is, the more words are distant
     */
    func levenshteinDistance(with anotherString: String, caseSensitive: Bool = true, diacriticSensitive: Bool = true) -> Int {
        guard count != 0 else {
            return anotherString.count
        }

        guard anotherString.count != 0 else {
            return count
        }

        // Create arrays from strings
        var firstString = self
        var secondString = anotherString
        if !caseSensitive {
            firstString = firstString.lowercased()
            secondString = secondString.lowercased()
        }
        if !diacriticSensitive {
            firstString = firstString.folding(options: .diacriticInsensitive, locale: Locale.current)
            secondString = secondString.folding(options: .diacriticInsensitive, locale: Locale.current)
        }
        let a = Array(firstString.utf16)
        let b = Array(secondString.utf16)

        // Initialize a 2D array for scores
        let scores = Array2D(rows: a.count + 1, columns: b.count + 1)

        // Fill scores of first word
        for i in 1...a.count {
            scores[i, 0] = i
        }

        // Fill scores of second word
        for j in 1...b.count {
            scores[0, j] = j
        }

        // Compute scores
        for i in 1...a.count {
            for j in 1...b.count {
                let cost: Int = a[i - 1] == b[j - 1] ? 0 : 1
                scores[i, j] = Swift.min(
                    scores[i - 1, j    ] + 1,   // deletion
                    scores[i, j - 1] + 1,   // insertion
                    scores[i - 1, j - 1] + cost // substitution
                )
            }
        }

        return scores[a.count, b.count]
    }

}
