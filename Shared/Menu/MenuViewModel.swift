//
//  MenuViewModel.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 25.08.2022.
//

import Foundation

struct PickerState {
    var selection: Languages
    var languages: [Languages]
}

protocol MenuViewModeling: ObservableObject {
    var nativePicker: PickerState { get set }
    var toLearnPicker: PickerState { get set }

    var selectedLanguage: SetLanguage { get }

    func nativeLanguageChanged()
    func toLearnLanguageChanged()
}

class MenuViewModel: MenuViewModeling {
    @Published var nativePicker: PickerState
    @Published var toLearnPicker: PickerState

    var selectedLanguage: SetLanguage {
        languageStore.currentLanguage
    }

    let languageStore: LanguageStore

    init(selectedLanguage: SetLanguage, languageStore: LanguageStore) {
        self.languageStore = languageStore

        nativePicker = PickerState(selection: selectedLanguage.language.main, languages: Languages.allCases)

        let toLearnLanguages = selectedLanguage.language.main == .uk ? Languages.allCases.filter { $0 != .uk } : [.uk]

        toLearnPicker = PickerState(selection: selectedLanguage.language.source,
                                    languages: toLearnLanguages)
    }

    func nativeLanguageChanged() {
        if nativePicker.selection != .uk {
            toLearnPicker = PickerState(selection: .uk, languages: [.uk])
        } else {
            let toLearnLanguages = Languages.allCases.filter { $0 != .uk }
            toLearnPicker = PickerState(selection: toLearnLanguages.first!,
                                        languages: toLearnLanguages)
        }

        saveSelectedLanguage()
    }

    func toLearnLanguageChanged() {
        saveSelectedLanguage()
    }

    private func saveSelectedLanguage() {
        let flip = nativePicker.selection == .uk
        let main = flip ? toLearnPicker.selection : nativePicker.selection
        let source = flip ? nativePicker.selection : toLearnPicker.selection

        languageStore.currentLanguage = SetLanguage(language: Language(main: main, source: source), flipFromWithTo: flip)
    }
}
