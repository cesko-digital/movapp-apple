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
                    
                    OnBoardingTutorialView(title: "boarding-1-title", subTitle: "boarding-1-sub-title", image: "icons/tutorial-dictionary")
                    
                    OnBoardingTutorialView(title: "boarding-2-title", subTitle: "boarding-2-sub-title", image: "icons/tutorial-child")
                    
                    OnBoardingTutorialView(title: "boarding-3-title", subTitle: "boarding-3-sub-title", image: "icons/tutorial-alphabet")
                    
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .accessibilityIdentifier("tutorial-tab-view")
                
                
                Button("Start learning", action: onStart)
                    .buttonStyle(PrimaryButtonStyle())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .accessibilityIdentifier("start-learning-button")
            }
            
            Button {
                onBack()
            } label: {
                Image(systemName: "chevron.left")
                
                Text("Back")
            }
            .accessibilityIdentifier("welcome-go-start")
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
