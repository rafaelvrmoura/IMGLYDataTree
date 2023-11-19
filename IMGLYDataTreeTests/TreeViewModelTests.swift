//
//  TreeViewModelTests.swift
//  IMGLYDataTreeTests
//
//  Created by Rafael Moura on 18/11/2023.
//

import XCTest

@testable import IMGLYDataTree

final class TreeViewModelTests: XCTestCase {

    func testBuildTreeViewHierarchy() async {

        let sut = await TreeViewModel(with: ServiceLayerMock.instance)

        await sut.loadTree()

        let currentState = await sut.state

        if case .loaded(let tree) = currentState {
            
            XCTAssertEqual(tree.count, 2)
            XCTAssertEqual(tree[0].children?.count, 2)
            XCTAssertEqual(tree[1].children?.count, 1)

        } else {
            
            XCTFail("Expected to find view model in loaded state")
        }
    }

    func testBuildTreeViewHierarchyError() async {

        let service = ServiceMockError(with: .anyError(message: "A error"))

        let sut = await TreeViewModel(with: service)

        await sut.loadTree()

        let currentState = await sut.state

        if case .error(let message) = currentState {
            
            XCTAssertEqual(message, "A error")

        } else {

            XCTFail("Expected to find view model in error state")
        }
    }

    func testDeleteNode() async {

        let sut = await TreeViewModel(with: ServiceLayerMock.instance)

        await sut.loadTree()

        await sut.remove(IndexSet(integer: 0))

        let currentState = await sut.state

        if case .loaded(let tree) = currentState {

            XCTAssertEqual(tree.count, 1)
            XCTAssertEqual(tree[0].label, "9elements")

        } else {

            XCTFail("Expected to find view model in loaded state")
        }
    }

    func testMoveNode() async {

        let sut = await TreeViewModel(with: ServiceLayerMock.instance)

        await sut.loadTree()

        await sut.move(childAt: IndexSet(integersIn: 0..<1), to: 2)

        let currentState = await sut.state

        if case .loaded(let tree) = currentState {

            XCTAssertEqual(tree.count, 2)
            XCTAssertEqual(tree[1].label, "img.ly")
            XCTAssertEqual(tree[0].label, "9elements")

        } else {

            XCTFail("Expected to find view model in loaded state")
        }
    }
}


