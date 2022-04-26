//
//  SectionHeaderView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import SwiftUI

struct AccordionHeaderView: View {
    let language: SetLanguage
    @Binding var selectedSection: Dictionary.Section?
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            
            if selectedSection != nil {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color("colors/secondary"))
                
                
                let text = selectedSection!.text(language: language)
                
                Text(text)
                    .foregroundColor(Color("colors/text"))
                    .lineLimit(1)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            withAnimation(.spring()) {
                selectedSection = nil
            }
        }
    }
}

struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AccordionHeaderView(language: .csUk, selectedSection: .constant(exampleSection))
    }
}
