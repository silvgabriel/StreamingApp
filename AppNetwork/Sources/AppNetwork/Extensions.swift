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
    func encoded(using encoder: JSONEncoder = JSONEncoder()) throws -> Data? {
        try encoder.encode(self)
    }
}

public extension Decodable {
    static func decoded(from data: Data, using decoder: JSONDecoder = JSONDecoder()) throws -> Self {
        try decoder.decode(self, from: data)
    }
}

public extension Array where Element: Encodable {
    func encoded(using encoder: JSONEncoder = JSONEncoder()) throws -> Data? {
        try encoder.encode(self)
    }
}
