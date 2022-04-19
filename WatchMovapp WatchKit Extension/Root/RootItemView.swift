//
//  RootItemView.swift
//  WatchMovapp WatchKit Extension
//
//  Created by Daryna Polevyk on 14.04.2022.
//

import SwiftUI

struct RootItemView: View {
    let imageName: String
    let title: String
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30, alignment: .leading)
                .foregroundColor(Color("colors/yellow"))
            
            Spacer()
            Text(title)
        }
        .padding()
    }
}

struct RootItemView_Previews: PreviewProvider {
    static var previews: some View {
        RootItemView(imageName: "icons/dictionary", title: "Dictionary")
    }
}
