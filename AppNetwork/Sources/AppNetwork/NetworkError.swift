//
//  NetworkError.swift
//  AppNetwork
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

import Foundation

public enum NetworkError: Error {
    /// Indicates that the provided URL is invalid.
    case invalidURL
    /// Indicates that the network request failed.
    /// - Parameters:
    ///   - data: The data returned from the failed request, if any.
    ///   - triedLocalJson: A Boolean value indicating whether a local JSON fallback was attempted.
    case requestFailed(data: Data, triedLocalJson: Bool)
}
