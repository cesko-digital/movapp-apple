//
//  StoriesRepository.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 27.10.2022.
//

import SwiftUI

protocol StoriesRepositoring {
    func loadStories() -> Result<StoriesMetadata, Error>
    func loadStory(slug: String) -> Result<StoryMetadata, Error>
}

class StoriesRepository: StoriesRepositoring {

    func loadStories() -> Result<StoriesMetadata, Error> {
        guard let asset = NSDataAsset(name: "data/stories/metadata") else {
            return .failure(AssetError(message: "`data/stories/metadata` not found"))
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let result = try decoder.decode(StoriesMetadata.self, from: asset.data)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }

    func loadStory(slug: String) -> Result<StoryMetadata, Error> {
        guard let asset = NSDataAsset(name: "data/stories/\(slug)/metadata") else {
            return .failure(AssetError(message: "\(slug) not found"))
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let result = try decoder.decode(StoryMetadata.self, from: asset.data)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}

struct AssetError: Error {
    let message: String
}
