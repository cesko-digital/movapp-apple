//
//  DictionaryHeaderView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 05.04.2022.
//


import SwiftUI


struct DictionaryHeaderView: View {
    @Binding var searchString: String
    
    var body: some View {
        HStack (spacing: 5) {
            TextField("Search", text: $searchString)
                .disableAutocorrection(true)
                .foregroundColor(Color("colors/text"))
                .padding(.trailing, 10)
                .padding(.leading, 26)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 0)
                    }
                )
            
            if !searchString.isEmpty {
                Button(
                    action: { searchString = "" },
                    label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
        }
        .padding(.horizontal, 10)
        .frame(height: 52)
        .background(Color("colors/input/background"))
        .cornerRadius(13)
        .padding(16)
        .background(Color("colors/primary"))
    }
}

struct DictionaryHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryHeaderView(searchString: .constant("Test"))
            .previewLayout(.sizeThatFits)
    }
}
