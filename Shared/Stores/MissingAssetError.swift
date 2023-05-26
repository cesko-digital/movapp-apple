//
//  MissingAssetError.swift
//  Movapp
//
//  Created by Jakub Ruzicka on 26.05.2023.
//

import Foundation

struct MissingAssetError: Error {

    let message: String

    init(_ message: String) {
        self.message = message
    }
}
