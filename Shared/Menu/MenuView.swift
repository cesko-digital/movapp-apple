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
            projectSection
            appSection
            partnerSection
        }
    }
    
    private var projectSection: some View {
        Section {
            
            Button("Web") {
                openUrl("https://movapp.cz")
            }
            
            Button("Twitter") {
                openUrl("https://twitter.com/movappcz")
            }
            
            Button("Facebook") {
                openUrl("https://www.facebook.com/movappcz")
            }
            
            Button("Instagram") {
                openUrl("https://www.instagram.com/movappcz/")
            }
            
            Button("LinkedIn") {
                openUrl("https://www.linkedin.com/company/movapp-cz/")
            }
            
        } header: {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            
            Text("menu.section.about_project.header")
        }
    }
    
    private var appSection: some View {
        Section {
            
            Button("menu.section.about_app.want_help") {
                openUrl("https://github.com/cesko-digital/movapp-apple")
            }
            
            Button("menu.section.about_app.license") {
                openUrl("https://github.com/cesko-digital/movapp-apple/blob/main/LICENSE")
            }
            
        } header: {
            Text("menu.section.about_app.header")
        } footer: {
            Text("Ver: \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild)) ")
        }
    }
    
    private var partnerSection: some View {
        Section {
            
            Button("Stojíme za Ukrajinou") {
                openUrl("https://www.stojimezaukrajinou.cz/")
            }
            
            Button("Umapa") {
                openUrl("https://www.umapa.eu/")
            }
            
        } header: {
            Text("menu.section.partner_projects.header")
        }
    }
    
    private func openUrl(_ urlString: String)  {
        
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
