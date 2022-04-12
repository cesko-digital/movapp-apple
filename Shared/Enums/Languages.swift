//
//  Languages.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 12.04.2022.
//

import Foundation

enum Languages: String {
    case cs = "cs"
    case uk = "uk"
    
    var flag: Flags {
        switch(self) {
        case .cs:
            return Flags.cs
        case .uk:
            return Flags.cs
        }
    }
    
    // TODO translate
    var title: String {
        switch(self) {
        case .cs:
            return "česky"
        case .uk:
            return "ukrainsky"
        }
    }
}
