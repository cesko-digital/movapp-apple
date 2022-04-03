//
//  DicitionaryView.swift
//  Movapp
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI


struct DicitionaryView: View {
    @State private var searchString: String = ""
    
    @State private var loaded: Bool?
    @State private var selectedSection: Section? = nil
    
    @State private var translations: Translations?
    @State private var sections: Sections?
    
    @State private var selectedLanguage: Language = Language.csUk
    
    func loadData () {
        let decoder = JSONDecoder()
        
        let prefix = selectedLanguage.filePrefix
        
        // TODO background thread
        if let asset = NSDataAsset(name: "sections-" + prefix) {
            let data = asset.data
            
            sections = try? decoder.decode([Section].self, from: data)
        }
        
        if let asset = NSDataAsset(name: "translations-" + prefix) {
            let data = asset.data
            
            translations = try? decoder.decode(Translations.self, from: data)
        }
        
        loaded = true
    }
    
    
    var body: some View {
        VStack (spacing: 0) {
            
            // Search bar
            HStack (spacing: 5) {
                TextField("Search", text: $searchString)
                    .disableAutocorrection(true)
                    .foregroundColor(Color("colors/text"))
                    .padding(.trailing, 10)
                    .padding(.leading, 26)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 0)
                        }
                    )
                
                if !searchString.isEmpty {
                    Button(
                        action: { searchString = "" },
                        label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color(UIColor.opaqueSeparator))
                        }
                    )
                }
                
                Picker("Select language", selection: $selectedLanguage) {
                    ForEach(Language.allCases, id: \.id) { value in
                        Text(value.rawValue)
                            .tag(value)
                    }
                }.onChange(of: selectedLanguage) { [selectedLanguage] newLanguage in
                    
                    if newLanguage.filePrefix != selectedLanguage.filePrefix {
                        loaded = false
                        translations = nil
                        sections = nil
                        // TODO TEST, this code should force new load
                    }
                }
                
            }
            .padding(.horizontal, 10)
            .frame(height: 52)
            .background(Color("colors/input/background"))
            .cornerRadius(13)
            .padding()
            .background(Color("colors/primary"))
            
            // Content
            
            if translations != nil && sections != nil {
                DictionaryContentView(
                    searchString: searchString,
                    language: selectedLanguage,
                    sections: sections!,
                    translations: translations!,
                    selectedSection: $selectedSection
                )
            } else {
                // Allign middle
                VStack {
                    Spacer()
                    if (loaded != nil) {
                        Text(
                            "Failed to load data",
                            comment: "When data has failed to load show this message"
                        )
                    } else {
                        ProgressView().onAppear(perform: loadData)
                    }
                    Spacer()
                }
            }
        }.onTapGesture {
            // Discard focus on the input if I tap somewhere
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
    }
}

struct DicitionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DicitionaryView()
    }
}
