//
//  OnBoardingTutorialView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.05.2022.
//

import SwiftUI

struct OnBoardingTutorialView: View {
    let title: LocalizedStringKey
    let subTitle: LocalizedStringKey
    let image: String
    
    @State var isVisible: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color("colors/yellow"))
                .frame(height: 250)
                .padding(.horizontal, 60)
            
            
            Text(title)
                .font(.system(.title))
                .foregroundColor(Color("colors/primary"))
            
            Text(subTitle)
                .foregroundColor(Color("colors/primary"))
                .multilineTextAlignment(.center)
        }
        .scaleEffect(isVisible ? 1.0 : 0.8)
        .animation(.spring(), value: isVisible)
        .padding()
        .onAppear {
            isVisible = true
        }
    }

}

struct OnBoardingTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingTutorialView(title: "Slovníček", subTitle: "Naučte se stovky základních slovíček a frází čtením i poslechem. Slovíčka třídíme dle životních situací.", image: "icons/dictionary")
            .previewLayout(.sizeThatFits)
    }
}
