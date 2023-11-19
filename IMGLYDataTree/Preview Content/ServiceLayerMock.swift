//
//  ServiceLayerMock.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import Foundation

final class ServiceLayerMock: ServiceLayerProtocol {

    static let instance = ServiceLayerMock()

    private let bundle: Bundle

    private lazy var decoder: JSONDecoder = {

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = JSONDecoderDateStrategy

        return decoder
    }()

    init(with bundle: Bundle = .main) {

        self.bundle = bundle
    }

    func requestTree() async throws -> [TreeNode] {

        guard let treeJOSN = bundle.url(forResource: "Tree", withExtension: ".json") else {

            return []
        }

        let data = try Data(contentsOf: treeJOSN)

        return try self.decoder.decode([TreeNode].self, from: data)

    }
    
    func requestEntryDetails(id: String) async throws -> EntryDetail {
        
        guard let entryJSON = bundle.url(forResource: "imgly.A.1", withExtension: ".json") else {

            return EntryDetail(id: nil, createdAt: nil, createdBy: nil, lastModifiedAt: nil, lastModifiedBy: nil, description: nil)

        }

        let data = try Data(contentsOf: entryJSON)

        return try self.decoder.decode(EntryDetail.self, from: data)
    }
}
