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
    
    func openLinkButton (_ title: String, url: String) -> some View {
        Button {
            openUrl(url)
        } label: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
    }
    
    private var projectSection: some View {
        Section {
            openLinkButton("Web", url: "https://movapp.cz")
            openLinkButton("Twitter", url: "https://twitter.com/movappcz")
            openLinkButton("Facebook", url: "https://www.facebook.com/movappcz")
            openLinkButton("Instagram", url: "https://www.instagram.com/movappcz/")
            openLinkButton("LinkedIn", url: "https://www.linkedin.com/company/movapp-cz")
            openLinkButton("Web", url: "https://movapp.cz")
            
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
            openLinkButton(String(localized: "menu.section.about_app.want_help"), url: "https://github.com/cesko-digital/movapp-apple")
            
            openLinkButton(String(localized: "menu.section.about_app.license"), url: "https://github.com/cesko-digital/movapp-apple/blob/main/LICENSE")
        } header: {
            Text("menu.section.about_app.header")
        } footer: {
            Text("Ver: \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild)) ")
        }
    }
    
    private var partnerSection: some View {
        Section {
            openLinkButton("Stojíme za Ukrajinou", url: "https://www.stojimezaukrajinou.cz/")
            
            openLinkButton("Umapa", url: "https://www.umapa.eu/")
            
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
