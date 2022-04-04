//
//  DictionaryContentView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import SwiftUI

struct DictionaryContentView: View {
    let searchString: String
    let language: SetLanguage
    let sections: Sections
    let translations: Translations
    
    @Binding var selectedSection: Section?
    
    var body: some View {
        VStack(spacing: 0) {
            if selectedSection != nil {
                AccordionHeaderView(language: language, selectedSection: $selectedSection)
                    .padding()
                
                let translationIds = selectedSection!.translations
                
                TranslationsView(
                    language: language,
                    searchString: searchString,
                    translations: translationIds.map({ translationId in
                        translations.byId[translationId]!
                    })
                )
            } else {
                if searchString == "" {
                    AccordionsView(
                        language: language,
                        sections: sections,
                        selectedSection: $selectedSection
                    )
                } else {
                    TranslationsView(
                        language: language,
                        searchString: searchString,
                        translations: Array(translations.byId.values)
                    )
                }
            }
        }
    }
}

struct DictionaryContentView_Previews: PreviewProvider {
    
    static var translations: Translations = Translations(byId: [
        "id1": exampleTranslation
    ])
    
    static var previews: some View {
        DictionaryContentView(
            searchString: "",
            language: SetLanguage.csUk,
            sections: [exampleSection],
            translations: translations,
            selectedSection: .constant(nil)
        )
        DictionaryContentView(
            searchString: "",
            language: SetLanguage.ukCs,
            sections: [exampleSection, exampleSection],
            translations: translations,
            selectedSection: .constant(exampleSection)
        )
    }
}
