//
//  MenuView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct MenuView: View {
    @State var selectedLanguage: SetLanguage;
    
    @EnvironmentObject var languageStore: LanguageStore
    @EnvironmentObject var onBoardingStore: OnBoardingStore
    
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
            .navigationTitle("Settings")
        }
    }
    
    private var settingsSection: some View {
        Section {
            
            Picker("Want to learn", selection: $selectedLanguage) {
                ForEach(SetLanguage.allCases, id: \.self) { value in
                    Text(LocalizedStringKey(value.title))
                        .tag(value)
                }
                .navigationTitle("Want to learn")
            }
            .foregroundColor(Color("colors/text"))
            .onChange(of: selectedLanguage) { newLanguage in
                
                languageStore.currentLanguage = newLanguage
            }
            
            #if DEBUG
            Button("Znova spustit on boarding") {
                withAnimation {
                    onBoardingStore.isBoardingCompleted.toggle()
                }
            }
            #endif
            
            
        } header: {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            
            Text("Settings")
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
                    .foregroundColor(Color("colors/text"))
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 12)
                    .foregroundColor(Color("colors/primary"))
            }
        }
    }
    
    private var projectSection: some View {
        Section {
            openLinkButton("movapp.cz", url: "https://movapp.cz")
            
            NavigationLink("Team") {
                TeamView()
                    .navigationTitle("Team")
            }
            
            openLinkButton("Twitter", url: "https://twitter.com/movappcz")
            openLinkButton("Facebook", url: "https://www.facebook.com/movappcz")
            openLinkButton("Instagram", url: "https://www.instagram.com/movappcz/")
            openLinkButton("LinkedIn", url: "https://www.linkedin.com/company/movapp-cz")
            
        } header: {
            Text("About the project", comment: "Settings")
        }
    }
    
    private var appSection: some View {
        Section {
            openLinkButton(String(localized: "I want to help"), url: "https://github.com/cesko-digital/movapp-apple")
            
            openLinkButton(String(localized: "License"), url: "https://github.com/cesko-digital/movapp-apple/blob/main/LICENSE")
        } header: {
            Text("About the app")
        }
    }
    
    private var partnerSection: some View {
        Section {
            openLinkButton(String(localized: "Stand by Ukraine", comment: "Link"), url: "https://www.stojimezaukrajinou.cz/")
            
            openLinkButton(String(localized: "Umapa", comment: "Link"), url: "https://www.umapa.eu/")
            
        } header: {
            Text("Partner project")
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
    static let userDefaultsStore = UserDefaultsStore()
    static let dictionaryDataStore = DictionaryDataStore()
    static let teamDataStore = TeamDataStore()
    static let languageStore = LanguageStore(userDefaultsStore: userDefaultsStore, dictionaryDataStore: dictionaryDataStore)
    static let onBoardingStore = OnBoardingStore(userDefaultsStore: userDefaultsStore)
    
    static var previews: some View {
        MenuView(selectedLanguage: .csUk)
            .environmentObject(languageStore)
            .environmentObject(teamDataStore)
            .environmentObject(onBoardingStore)
    }
}
