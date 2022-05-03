//
//  OnBoardingTutorialsPagerView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.05.2022.
//

import SwiftUI

struct OnBoardingTutorialsPagerView: View {
    let onBack: () -> Void
    let onStart: () -> Void
    
    var body: some View {
        ZStack(alignment: .topLeading) {
             
            VStack {
                TabView {
                    
                    OnBoardingTutorialView(title: "Slovníček", subTitle: "Naučte se stovky základních slovíček a frází čtením i poslechem. Slovíčka třídíme dle životních situací.", image: "icons/tutorial-dictionary")
                    
                    OnBoardingTutorialView(title: "Pro děti", subTitle: "Ilustrovaný ukrajinsko-český slovníček s desítkami tisknutelných karet.", image: "icons/tutorial-child")
                    
                    OnBoardingTutorialView(title: "Ukrajinská abeceda", subTitle: "Naučte se všechny znaky ukrajinské cyrilice. Pomohou vám ukázková slova.", image: "icons/tutorial-alphabet")
                    
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                
                Button("Začít s účením", action: onStart)
                    .buttonStyle(PrimaryButtonStyle())
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            
            Button {
                onBack()
            } label: {
                Image(systemName: "chevron.left")
                
                Text("Back")
            }
            .accessibilityIdentifier("welcome-start")
            .padding()
        }
    }
    
}

struct OnBoardingTutorialsPagerView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingTutorialsPagerView {
            print("Back")
        } onStart: {
            print("Start")
        }
        
    }
}
