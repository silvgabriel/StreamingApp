//
//  NetworkExecutor.swift
//  AppNetwork
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

import Foundation

/// Protocol that defines an executor responsible for performing network requests.
public protocol NetworkExecutorProtocol {
    /// Performs a network request and returns the response data and URL response.
    /// - Parameter request: The URLRequest to be executed.
    /// - Returns: A tuple containing the response data and URLResponse.
    /// - Throws: An error if the request fails.
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
