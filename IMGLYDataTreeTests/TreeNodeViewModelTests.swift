//
//  TreeNodeViewModelTests.swift
//  IMGLYDataTreeTests
//
//  Created by Rafael Moura on 18/11/2023.
//

import XCTest

@testable import IMGLYDataTree

final class TreeNodeViewModelTests: XCTestCase {

    func testDeleteChild() throws {

        let sut = TreeNodeViewModel(node: try makeTreeNode(), isExpanded: true)

        // Before removing
        XCTAssertEqual(sut.children?.count, 2)
        XCTAssertEqual(sut.children?[0].label, "Workspace A")

        sut.removeChild(at: IndexSet(integer: 0))

        // After removing
        XCTAssertEqual(sut.children?.count, 1)
        XCTAssertEqual(sut.children?[0].label, "Workspace B")
    }

    func testMoveChild() throws {

        let sut = TreeNodeViewModel(node: try makeTreeNode(), isExpanded: true)

        // Before moving
        XCTAssertEqual(sut.children?.count, 2)
        XCTAssertEqual(sut.children?[0].label, "Workspace A")
        XCTAssertEqual(sut.children?[1].label, "Workspace B")

        sut.move(childAt: IndexSet(integersIn: 0..<1), to: 2)

        // After moving
        XCTAssertEqual(sut.children?.count, 2)
        XCTAssertEqual(sut.children?[0].label, "Workspace B")
        XCTAssertEqual(sut.children?[1].label, "Workspace A")

    }

    private func makeTreeNode() throws -> TreeNode {

        let jsonURL = try XCTUnwrap(Bundle(for: Self.self).url(forResource: "TreeNode", withExtension: ".json"))

        let data = try Data(contentsOf: jsonURL)

        return try JSONDecoder().decode(TreeNode.self, from: data)
    }
}
