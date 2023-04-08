//
//  MovappTests.swift
//  MovappTests
//
//  Created by Jakub Ruzicka on 25.03.2023.
//

import XCTest
@testable import Movapp

final class StoriesRepositoryTests: XCTestCase {

    func testLoadStories() throws {
        let repository = StoriesRepository()

        let result = repository.loadStories()

        // Assert
        switch result {
        case .success(let metadata):
            metadata.stories.forEach { story in
                let storyMetadataResult = repository.loadStory(slug: story.slug)
                switch storyMetadataResult {
                case .failure(let error):
                    XCTFail("Unexpected error: \(error.localizedDescription)")
                case .success:
                    break
                }

                let firstLanguage = NSDataAsset(name: "data/stories/\(story.slug)/\(story.supportedLanguages[0])")
                XCTAssertNotNil(firstLanguage, "First supported sound for \(story.slug) not found")
                let secondLanguage = NSDataAsset(name: "data/stories/\(story.slug)/\(story.supportedLanguages[1])")
                XCTAssertNotNil(secondLanguage, "Second supported sound for \(story.slug) not found")
                let image = UIImage(named: "images/\(story.slug)")
                XCTAssertNotNil(image, "Missing image for story \(story.slug)")
            }
        case .failure(let error):
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testLoadNotExistingStory() throws {
        let repository = StoriesRepository()

        let result = repository.loadStory(slug: "notExistingSlug 🚫")

        switch result {
        case .success:
            XCTFail("This should not happen")
        case .failure(let failure):
            XCTAssertEqual(failure.localizedDescription,
                           AssetError(message: "notExistingSlug 🚫 not found").localizedDescription)
        }
    }
}
