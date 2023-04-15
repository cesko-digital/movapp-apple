//
//  MenuView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct MenuView<ViewModel: MenuViewModeling>: View {
    @StateObject var viewModel: ViewModel

    @EnvironmentObject var onBoardingStore: OnBoardingStore

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
            .navigationTitle("settings")
        }
        .navigationViewStyle(.stack)
    }

    private var settingsSection: some View {
        Section {
            NavigationLink {
                PickerView(selectedItem: viewModel.nativePicker.selection,
                           items: viewModel.nativePicker.languages,
                           titleKeyPath: \.title) { value in
                    viewModel.nativePicker.selection = value
                    viewModel.nativeLanguageChanged()
                }
                           .navigationTitle("i_know")
            } label: {
                HStack {
                    Text("i_know")
                    Spacer()
                    Text(LocalizedStringKey(viewModel.nativePicker.selection.title))
                }
            }

            NavigationLink {
                PickerView(selectedItem: viewModel.toLearnPicker.selection,
                           items: viewModel.toLearnPicker.languages,
                           titleKeyPath: \.titleAccusative) { value in
                    viewModel.toLearnPicker.selection = value
                    viewModel.toLearnLanguageChanged()
                }
                           .navigationTitle("i_want_learn")
            } label: {
                HStack {
                    Text("i_want_learn")
                    Spacer()
                    Text(LocalizedStringKey(viewModel.toLearnPicker.selection.titleAccusative))
                }
            }

#if DEBUG
            if CommandLine.arguments.contains("allow-onboarding-reset") {
                Button("Znova spustit on boarding") {
                    withAnimation {
                        onBoardingStore.isBoardingCompleted.toggle()
                    }
                }
            }
#endif

        } header: {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)

            Text("settings")
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

            NavigationLink("about_team") {
                TeamView(selectedLanguage: viewModel.selectedLanguage)
                    .navigationTitle("about_team")
            }

            openLinkButton(String(localized: "about_twitter"), url: "https://twitter.com/movappcz")
            openLinkButton(String(localized: "facebook"), url: "https://www.facebook.com/movappcz")
            openLinkButton(String(localized: "about_instagram"), url: "https://www.instagram.com/movappcz/")
            openLinkButton(String(localized: "linkedin"), url: "https://www.linkedin.com/company/movapp-cz")

        } header: {
            Text("about_project", comment: "Settings")
        }
    }

    private var appSection: some View {
        Section {
            openLinkButton(String(localized: "i_want_help"), url: "https://github.com/cesko-digital/movapp-apple")

            openLinkButton(String(localized: "about_license"),
                           url: "https://github.com/cesko-digital/movapp-apple/blob/main/LICENSE")
        } header: {
            Text("about_application")
        }
    }

    private var partnerSection: some View {
        Section {
            openLinkButton(String(localized: "about_stand_by_ukraine"), url: "https://www.stojimezaukrajinou.cz/")

            openLinkButton(String(localized: "about_umapa"), url: "https://www.umapa.eu/")

        } header: {
            Text("about_partners")
        }
    }

    private func openUrl(_ urlString: String) {
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
    static let dictionaryDataStore = DictionaryDataStore.shared
    static let teamDataStore = TeamDataStore()
    static let languageStore = LanguageStore(
        userDefaultsStore: userDefaultsStore,
        dictionaryDataStore: dictionaryDataStore,
        forChildrenDataStore: ForChildrenDataStore(dictionaryDataStore: dictionaryDataStore)
    )
    static let onBoardingStore = OnBoardingStore(userDefaultsStore: userDefaultsStore)

    static var previews: some View {
        MenuView(viewModel: MenuViewModel(selectedLanguage: .csUk, languageStore: languageStore))
            .environmentObject(teamDataStore)
            .environmentObject(onBoardingStore)
            .previewLayout(.sizeThatFits)
            .frame(height: 950)
    }
}
