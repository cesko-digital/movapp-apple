//
//  AccordionsView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct AccordionsView: View {

    let language: SetLanguage
    let categories: [Dictionary.Category]

    @Binding var selectedCategory: Dictionary.Category?

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(Array(categories.enumerated()), id: \.0) { index, category in
                    let isOdd = (index % 2) != 0
                    let text = category.text(language: language)

                    AccordionView(isOdd: isOdd, text: text)
                        .accessibilityIdentifier("dictionary_\(index)")
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedCategory = category
                            }
                        }
                }
            }
            .padding()
            .background(Color("colors/background"))
        }
    }
}

struct AccordionsView_Previews: PreviewProvider {

    @State static var emptyCategory: Dictionary.Category?
    @State static var category: Dictionary.Category? = exampleCategory

    static var previews: some View {

        AccordionsView(language: .csUk, categories: [], selectedCategory: $emptyCategory)

        AccordionsView(language: .ukCs, categories: [], selectedCategory: $category)
    }
}
