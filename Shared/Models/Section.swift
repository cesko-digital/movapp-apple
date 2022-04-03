//
//  Section.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import Foundation


struct Section: Decodable, Identifiable {
    let id: String
    // TODO rename to more universal, language will have own json
    let name_from: String // name_from
    let name_to: String // name_to
    
    // TODO rename
    let translations: [String]
    
    func text(language: Language) -> String {
        let arguments = [name_from , name_to]
        return String(format: "%@ - %@", arguments: language.flipFromWithTo ? arguments.reversed() : arguments)
    }
}

typealias Sections = [Section]


#if DEBUG
let exampleSection = Section(
    id: "f22b3b19f76d8857a3171412fb5f35fc",
    name_from: "Základní fráze",
    name_to: "Основні фрази",
    translations: ["d6e710c7f44b67220cd9b870e6107bf9"]
)
#endif
