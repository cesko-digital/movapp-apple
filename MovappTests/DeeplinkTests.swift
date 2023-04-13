//
//  DeeplinkTests.swift
//  MovappTests
//
//  Created by Jakub Ruzicka on 12.04.2023.
//

import XCTest
@testable import Movapp

final class DeeplinkTests: XCTestCase {

    func testUrl() throws {
        let deeplink = Deeplink.phrase("recwA7uQYnXczMqOb")

        XCTAssertNotNil(deeplink.url, "Deeplink url should not be nil")
        XCTAssertEqual(deeplink.url?.absoluteString, "movapp://phrase/recwA7uQYnXczMqOb", "Serialization failed")
    }

    func testInit() throws {
        let given = "movapp://phrase/recwA7uQYnXczMqOb"

        let deeplink = Deeplink(from: URL(string: given))

        XCTAssertNotNil(deeplink, "Deeplink url should not be nil")
        XCTAssertEqual(deeplink?.url?.absoluteString, "movapp://phrase/recwA7uQYnXczMqOb", "Deserialization failed")
    }

    func testInvalid() throws {
        let given = "movp://phrase/recwA7uQYnXczMqOb"

        let deeplink = Deeplink(from: URL(string: given))

        XCTAssertNil(deeplink, "Deeplink url should be nil")
    }
}
