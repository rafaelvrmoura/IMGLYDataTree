//
//  IMGLYServiceLayer.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import Foundation

protocol ServiceLayerProtocol: AnyObject {

    func requestTree() async throws -> [TreeNode]
    func requestEntryDetails(id: String) async throws -> EntryDetail
}

final class IMGLYServiceLayer: ObservableObject, ServiceLayerProtocol {

    let provider = DataProvider()

    func requestTree() async throws -> [TreeNode] {

        return try await provider.request(.tree)
    }

    func requestEntryDetails(id: String) async throws -> EntryDetail {

        return try await provider.request(.entryDetails(id: id))
    }
}
