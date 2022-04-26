//
//  MenuView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct MenuView: View {
    @State var selectedLanguage: SetLanguage = .csUk;
    
    @EnvironmentObject var languageService: LanguageService
    
    init (selectedLanguage: SetLanguage) {
        self.selectedLanguage = selectedLanguage
    }
    
    var body: some View {
        
        NavigationView {
            
            List {
                settingsSection
                projectSection
                appSection
                partnerSection
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .navigationTitle("tabbar.menu")
        }
    }
    
    private var settingsSection: some View {
        Section {
            
            Picker("menu.section.settings.learn", selection: $selectedLanguage) {
                ForEach(SetLanguage.allCases, id: \.self) { value in
                    Text(LocalizedStringKey(value.title))
                        .tag(value)
                }
                .navigationTitle("menu.section.settings.learn")
            }
            .onChange(of: selectedLanguage) { newLanguage in
                
                languageService.currentLanguage = newLanguage
            }
            
            
        } header: {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            
            Text("menu.section.settings.header")
        } footer: {
            Text("Ver: \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild)) ")
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
            Text("menu.section.about_project.header")
        }
    }
    
    private var appSection: some View {
        Section {
            openLinkButton(String(localized: "menu.section.about_app.want_help"), url: "https://github.com/cesko-digital/movapp-apple")
            
            openLinkButton(String(localized: "menu.section.about_app.license"), url: "https://github.com/cesko-digital/movapp-apple/blob/main/LICENSE")
        } header: {
            Text("menu.section.about_app.header")
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
        MenuView(selectedLanguage: .csUk).environmentObject(LanguageService(dictionaryDataStore: DictionaryDataStore()))
    }
}
