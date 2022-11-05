//
//  StoriesRepository.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 27.10.2022.
//

import SwiftUI

class StoriesRepository {

    func loadStories() -> StoriesMetadata? {
        guard let asset = NSDataAsset(name: "data/stories/metadata") else {
            return nil
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try? decoder.decode(StoriesMetadata.self, from: asset.data)
    }

    func loadStory(slug: String) -> StoryMetadata? {
        guard let asset = NSDataAsset(name: "data/stories/\(slug)/metadata") else {
            return nil
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try? decoder.decode(StoryMetadata.self, from: asset.data)
    }
}
