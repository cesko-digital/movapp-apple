//
//  StoriesRepository.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 27.10.2022.
//

import SwiftUI

class StoriesRepository {

    func loadStories() -> [StoryMetadata]? {
        guard let asset = NSDataAsset(name: "data/stories/metadata") else {
            return nil
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try? decoder.decode([StoryMetadata].self, from: asset.data)
    }
}
