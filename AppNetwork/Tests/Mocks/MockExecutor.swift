//
//  MockExecutor.swift
//  AppNetwork
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

import AppNetwork

class MockExecutor: NetworkExecutorProtocol {

    // MARK: - Properties
    var mockResponse: URLResponse?
    var mockData: Data?
    var shouldThrowError = false

    // MARK: - Public Methods
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if shouldThrowError {
            throw URLError(.notConnectedToInternet)
        }

        guard let response = mockResponse, let data = mockData else {
            throw URLError(.badServerResponse)
        }

        return (data, response)
    }
}
