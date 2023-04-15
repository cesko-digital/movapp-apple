//
//  MovappApp.swift
//  Shared
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

@main
struct MovappApp: App {

    let dictionaryDataStore = DictionaryDataStore.shared
    let forChildrenDataStore: ForChildrenDataStore
    let userDefaultsStore = UserDefaultsStore()
    let teamDataStore = TeamDataStore()

    let languageStore: LanguageStore
    let soundService = SoundService()
    let favoritesProvider: PhrasesFavoritesProvider
    let favoritesService: PhraseFavoritesService

    @ObservedObject var onBoardingDataStore: OnBoardingStore

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear // gets also rid of the bottom border of the navigation bar
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Color("colors/primary"))
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        // white back text
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        // white back arrow
        let image = UIImage(systemName: "chevron.backward")?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)

        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        self.forChildrenDataStore = ForChildrenDataStore(dictionaryDataStore: dictionaryDataStore)
        self.languageStore = LanguageStore(userDefaultsStore: userDefaultsStore,
                                           dictionaryDataStore: dictionaryDataStore,
                                           forChildrenDataStore: forChildrenDataStore)
        self.onBoardingDataStore = OnBoardingStore(userDefaultsStore: userDefaultsStore)
        self.favoritesService = PhraseFavoritesService(userDefaultsStore: userDefaultsStore,
                                                       dictionaryDataStore: dictionaryDataStore)
        self.favoritesProvider = PhrasesFavoritesProvider(favoritesService: favoritesService)
    }

    var body: some Scene {
        WindowGroup {
            if onBoardingDataStore.isBoardingCompleted {
                RootContentView()
                    .environmentObject(languageStore)
                    .environmentObject(soundService)
                    .environmentObject(favoritesService)
                    .environmentObject(favoritesProvider)
                    .environmentObject(dictionaryDataStore)
                    .environmentObject(forChildrenDataStore)
                    .environmentObject(teamDataStore)
                    .environmentObject(onBoardingDataStore)
                    .onAppear {
                        setChristmasIconIfAvailable()
                    }
            } else {
                OnBoardingRootView()
                    .environmentObject(languageStore)
                    .environmentObject(onBoardingDataStore)
            }
        }
    }

    private func setChristmasIconIfAvailable() {
        guard userDefaultsStore.disableSetIcon() == false else {
            return
        }

        let app = UIApplication.shared
        let currentYear = Calendar.current.dateComponents([.year], from: Date()).year ?? 0

        guard
            app.supportsAlternateIcons,
            let startDate = Calendar.current.date(from: DateComponents(year: currentYear, month: 12, day: 1)),
            let endDate = Calendar.current.date(from: DateComponents(year: currentYear + 1, month: 1, day: 10))
        else {
            return
        }

        let christmasIconName = "Christmas"
        let christmasSeason = DateInterval(start: startDate, end: endDate)
        let isChristmasSeason = christmasSeason.contains(Date())
        var shouldChangeIcon = false
        var newIcon: String?

        if isChristmasSeason, app.alternateIconName == nil {
            shouldChangeIcon = true
            newIcon = christmasIconName
        }

        if !isChristmasSeason, app.alternateIconName == christmasIconName {
            shouldChangeIcon = true
        }

        guard shouldChangeIcon else { return }

        // Hack to trigger the change due to dialog
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            Task { @MainActor in
                do {
                    try await UIApplication.shared.setAlternateIconName(newIcon)
                } catch {
                    print("App icon failed to set: \(error.localizedDescription)")
                }
            }
        }
    }
}
