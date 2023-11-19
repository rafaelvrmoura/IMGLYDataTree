//
//  ServiceMockError.swift
//  IMGLYDataTreeTests
//
//  Created by Rafael Moura on 19/11/2023.
//

import Foundation

@testable import IMGLYDataTree

final class ServiceMockError: ServiceLayerProtocol {

    enum Error: LocalizedError {

        case anyError(message: String)

        var errorDescription: String? {

            switch self {
            case .anyError(let message): return message
            }
        }
    }

    let error: Error

    init(with error: ServiceMockError.Error) {

        self.error = error
    }

    func requestTree() async throws -> [TreeNode] {

        throw error
    }
    
    func requestEntryDetails(id: String) async throws -> EntryDetail {

        throw error
    }
}
