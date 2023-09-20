//
//  TeamDataStoreTests.swift
//  MovappTests
//
//  Created by Jakub Ruzicka on 25.03.2023.
//

@testable import Movapp
import XCTest

final class TeamDataStoreTests: XCTestCase {

    func testLoaded() throws {
        let dataStore = TeamDataStore()

        dataStore.load()

        XCTAssertFalse(dataStore.loading)
        XCTAssertNil(dataStore.error)
        XCTAssertNotNil(dataStore.team)
    }
}
