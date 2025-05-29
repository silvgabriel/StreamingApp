//
//  NetworkService.swift
//  AppNetwork
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

@_exported import Foundation

public class NetworkService<T: APIProtocol>: @unchecked Sendable {

    // MARK: - Properties
    private let executor: NetworkExecutorProtocol

    // MARK: - Initializers
    public init(executor: NetworkExecutorProtocol = URLSession.shared) {
        self.executor = executor
    }

    // MARK: - Public Methods
    public func request(_ apiData: T, body: Encodable? = nil) async throws -> Data {
        let urlRequest = try apiData.buildURLRequest(requestBody: body?.encoded())
        let (data, response) = try await executor.data(for: urlRequest)

        guard response.isSuccess() else {
            if let fallbackJson = apiData.fallbackJSONFile,
               let path = Bundle.main.path(forResource: fallbackJson, ofType: "json"),
               let fallbackData = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                return fallbackData
            }

            throw NetworkError.requestFailed(data: data, triedLocalJson: apiData.fallbackJSONFile != nil)
        }

        return data
    }
}

// MARK: - NetworkExecutor
extension URLSession: NetworkExecutorProtocol {}
