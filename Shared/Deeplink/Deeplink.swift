//
//  Deeplink.swift
//  Movapp
//
//  Created by Jakub Ruzicka on 12.04.2023.
//

import Foundation

private let scheme = "movapp:/"

enum Deeplink {
    case phrase(String)

    var description: String {
        switch self {
        case .phrase(let id):
            return "\(scheme)/phrase/\(id)"
        }
    }
}

extension Deeplink {
    var url: URL? {
        return URL(string: description)
    }
}

extension Deeplink {
    init?(from: URL?) {
        guard let url = from else { return nil }

        guard url.scheme != scheme else { return nil }

        guard url.pathComponents.contains("phrase") else { return nil }

        self = Deeplink.phrase(url.lastPathComponent)
    }
}
