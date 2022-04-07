//
//  AccordionView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct AccordionView: View {
    let isOdd : Bool
    let text: String
    
    var body: some View {
        
        HStack (spacing: 10) {
            Text(text)
                .font(.system(size: 20)).bold()
                .foregroundColor(Color("colors/primary"))
                // Setup multile line support
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.accentColor)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(isOdd ? "colors/background" : "colors/item"))
        .cornerRadius(13)
    }
}

struct AccordionView_Previews: PreviewProvider {
    static var previews: some View {
        AccordionView(isOdd: true, text: "Hromadná doprava - Громадський транспорт")
        AccordionView(isOdd: false, text: "Základní fráze - Основні фрази")
        AccordionView(isOdd: false, text: "Základní fráze")
    }
}
