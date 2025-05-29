//
//  Extensions.swift
//  AppNetwork
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

import Foundation

internal extension URLResponse {
    /// Checks if the response has a successful HTTP status code (2xx).
    /// - Returns: `true` if the status code is in the 200-299 range, otherwise `false`.
    func isSuccess() -> Bool {
        let statusCode = (self as? HTTPURLResponse)?.statusCode ?? 0
        return 200..<300 ~= statusCode
    }
}

public extension Encodable {
    /// Encodes the object to JSON data using the provided encoder.
    /// - Parameter encoder: The JSONEncoder to use. Defaults to a new JSONEncoder instance.
    /// - Throws: An error if encoding fails.
    /// - Returns: The encoded data.
    func encoded(using encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        try encoder.encode(self)
    }
}

public extension Decodable {
    /// Decodes an instance of the type from the given data using the provided decoder.
    /// - Parameters:
    ///   - data: The data to decode from.
    ///   - decoder: The JSONDecoder to use. Defaults to a new JSONDecoder instance.
    /// - Throws: An error if decoding fails.
    /// - Returns: A decoded instance of the type.
    static func decoded(from data: Data, using decoder: JSONDecoder = JSONDecoder()) throws -> Self {
        try decoder.decode(self, from: data)
    }
}

public extension Array where Element: Encodable {
    /// Encodes the array to JSON data using the provided encoder.
    /// - Parameter encoder: The JSONEncoder to use. Defaults to a new JSONEncoder instance.
    /// - Throws: An error if encoding fails.
    /// - Returns: The encoded data.
    func encoded(using encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        try encoder.encode(self)
    }
}
