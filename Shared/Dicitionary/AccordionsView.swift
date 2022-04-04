//
//  AccordionsView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct AccordionsView: View {
    
    let language: SetLanguage
    let sections: Sections
    
    @Binding var selectedSection: Section?
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(Array(sections.enumerated()), id: \.0)  { index, section in
                    let isOdd = (index % 2) != 0
                    let text = section.text(language: language)
                    
                    AccordionView(isOdd: isOdd, text:  text)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedSection = section
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
    
    @State static var emptySection: Section? = nil
    @State static var section: Section? = exampleSection
    
    static var previews: some View {
        
        AccordionsView(language: .csUk, sections: [], selectedSection: $emptySection)
        
        AccordionsView(language: .ukCs, sections: [], selectedSection: $section)
    }
}
