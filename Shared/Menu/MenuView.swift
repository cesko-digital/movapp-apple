//
//  MenuView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI



struct MenuView: View {
    var body: some View {
        
        List {
            Section {
                Button("Web") {
                    openUrl("https://movapp.cz")
                }
                
                Button("Twitter") {
                    openUrl("https://twitter.com/movappcz")
                }
                
                Button("Instagram") {
                    openUrl("https://www.instagram.com/movappcz/")
                }
            } header: {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Text("O projektu")
            }
            
            
            Section {
                Button("Chci vylepšit aplikaci") {
                    openUrl("https://github.com/cesko-digital/movapp-apple")
                }
                
                Button("Licence") {
                    openUrl("https://github.com/cesko-digital/movapp-apple/blob/main/LICENSE")
                }
            } header: {
                Text("O aplikaci")
            } footer: {
                Text("Ver: \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild)) ")
                    
            }
        }
        
    }
    
    func openUrl(_ urlString: String)  {
        guard let url = URL(string: urlString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
