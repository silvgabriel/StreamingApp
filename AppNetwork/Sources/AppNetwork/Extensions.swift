//
//  Extensions.swift
//  AppNetwork
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

import Foundation

internal extension URLResponse {
    func isSuccess() -> Bool {
        let statusCode = (self as? HTTPURLResponse)?.statusCode ?? 0
        return 200..<300 ~= statusCode
    }
}

public extension Encodable {
    func encoded() throws -> Data? {
        try JSONEncoder().encode(self)
    }
}

public extension Array where Element: Encodable {
    func encode() throws -> Data? {
        try JSONEncoder().encode(self)
    }
}

public extension Decodable {
    static func decoded(from data: Data) throws -> Self {
        try JSONDecoder().decode(self, from: data)
    }
}
