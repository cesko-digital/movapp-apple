//
//  TeamDataStoreTests.swift
//  MovappTests
//
//  Created by Jakub Ruzicka on 25.03.2023.
//

import XCTest
@testable import Movapp

final class TeamDataStoreTests: XCTestCase {

    func testLoaded() throws {
        let dataStore = TeamDataStore()

        dataStore.load()

        XCTAssertFalse(dataStore.loading)
        XCTAssertNil(dataStore.error)
        XCTAssertNotNil(dataStore.team)
    }
}
