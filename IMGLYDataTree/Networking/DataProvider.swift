//
//  DataProvider.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import Foundation

private typealias TaskResult = (data: Data, response: URLResponse)

let JSONDecoderDateStrategy = JSONDecoder.DateDecodingStrategy.custom { decoder in
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

final class DataProvider {

    enum Error: LocalizedError {

        case httpError(underlying: String?, code: Int)
        case badResponse
        case empty

        var errorDescription: String? {

            switch self {
            case.httpError(let underlying, let code):
                return underlying ?? "HTTP Error code: \(code)"
            case .empty:
                return "The requested resource does not exist"
            case .badResponse:
                return "Not expected response from server"
            }
        }
    }

    private lazy var decoder: JSONDecoder = {

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = JSONDecoderDateStrategy

        return decoder
    }()

    func request<T: Decodable>(_ resource: IMGLYAPI) async throws -> T {

        let request = URLRequest(url: resource.url)

        let result: TaskResult  = try await URLSession.shared.data(for: request)

        guard let response = result.response as? HTTPURLResponse else {

            throw Error.badResponse
        }

        switch response.statusCode {

        case 200:
            return try decoder.decode(T.self, from: result.data)

        case 404:
            throw Error.empty

        default:
            throw Error.httpError(underlying: String(data: result.data,
                                                     encoding: .utf8),
                                  code: response.statusCode)
        }
    }
}
