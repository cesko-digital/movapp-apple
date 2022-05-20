//
//  AccordionHeaderView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import SwiftUI

struct AccordionHeaderView: View {
    let language: SetLanguage
    @Binding var selectedCategory: Dictionary.Category?
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            
            if selectedCategory != nil {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color("colors/secondary"))
                
                
                let text = selectedCategory!.text(language: language)
                
                Text(text)
                    .foregroundColor(Color("colors/text"))
                    .lineLimit(1)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            withAnimation(.spring()) {
                selectedCategory = nil
            }
        }
    }
}

struct AccordionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AccordionHeaderView(language: .csUk, selectedCategory: .constant(exampleCategory))
    }
}
