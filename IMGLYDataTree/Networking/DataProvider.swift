//
//  DataProvider.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import Foundation

final class DataProvider {

    private lazy var decoder: JSONDecoder = {

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            if let date = formatter.date(from: dateStr) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string")
            }
        }

        return decoder
    }()

    func request<T: Decodable>(_ resource: IMGLYAPI) async throws -> T {

        let request = URLRequest(url: resource.url)

        let data = try await URLSession.shared.data(for: request).0

        return try decoder.decode(T.self, from: data)
    }
}
