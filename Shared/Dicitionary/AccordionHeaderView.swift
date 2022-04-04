//
//  SectionHeaderView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import SwiftUI

struct AccordionHeaderView: View {
    let language: SetLanguage
    @Binding var selectedSection: Section?
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            
            if selectedSection != nil {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color("colors/secondary"))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedSection = nil
                        }
                    }
                
                
                let text = selectedSection!.text(language: language)
                
                Text(text)
                    .foregroundColor(Color("colors/text"))
                    .lineLimit(1)
                Spacer()
            }
        }.frame(maxWidth: .infinity)
    }
}

struct SectionHeaderView_Previews: PreviewProvider {
    
    @State static var section: Section? = exampleSection
    
    static var previews: some View {
        AccordionHeaderView(language: .csUk, selectedSection: $section)
    }
}
