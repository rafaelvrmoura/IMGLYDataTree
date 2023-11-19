//
//  EntryDetailsViewModelTests.swift
//  IMGLYDataTreeTests
//
//  Created by Rafael Moura on 18/11/2023.
//

import XCTest

@testable import IMGLYDataTree

final class EntryDetailsViewModelTests: XCTestCase {

    func testLoadDetailError() async {

        let service = ServiceMockError(with: .anyError(message: "Load Error"))

        let sut = await EntryDetailsViewModel(with: service)

        await sut.loadDetails(forEntryWith: "imgly.A.1")

        if case .error(let message) = await sut.state {

            XCTAssertEqual(message, "Load Error")

        } else {

            XCTFail("Expected to find view model in error state")
        }
    }

    func testLoadDetailSucceeded() async {

        let sut = await EntryDetailsViewModel(with: ServiceLayerMock.instance)

        guard case .loading = await sut.state else {

            XCTFail("Expected to find view model in loading state")
            return
        }

        await sut.loadDetails(forEntryWith: "imgly.A.1")

        if case .loaded(let details) = await sut.state {

            XCTAssertEqual(details.count, 6)
            XCTAssertEqual(details[0].title, "Id")
            XCTAssertEqual(details[1].title, "Created at")
            XCTAssertEqual(details[1].description, "7/14/2024, 3:33:17 AM")
            XCTAssertEqual(details[2].title, "Created by")
            XCTAssertEqual(details[3].title, "Last modified at")
            XCTAssertEqual(details[3].description, "9/30/2082, 8:54:40 PM")
            XCTAssertEqual(details[4].title, "Last modified by")
            XCTAssertEqual(details[5].title, "Description")

        } else {

            XCTFail("Expected to find view model in loaded state")
        }
    }
}
