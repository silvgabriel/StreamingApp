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
    /// Initializes a new instance of NetworkService with the given executor.
    /// - Parameter executor: The network executor to use for requests. Defaults to URLSession.shared.
    public init(executor: NetworkExecutorProtocol = URLSession.shared) {
        self.executor = executor
    }

    // MARK: - Public Methods
    /// Sends a network request using the provided API data and optional request body.
    /// - Parameters:
    ///   - apiData: The API endpoint configuration conforming to APIProtocol.
    ///   - body: An optional Encodable object to be sent as the request body.
    /// - Returns: The response data from the network request or fallback JSON if available.
    /// - Throws: NetworkError if the request fails and no fallback is available.
    public func request(_ apiData: T, body: Encodable? = nil) async throws -> Data {
        do {
            let urlRequest = try apiData.buildURLRequest(requestBody: body?.encoded())
            let (data, response) = try await executor.data(for: urlRequest)

            guard response.isSuccess() else {
                if let data = getLocalJSONData(using: apiData) {
                    return data
                }

                throw NetworkError.requestFailed(data: data, triedLocalJson: apiData.fallbackJSONFile != nil)
            }

            return data
        } catch {
            if let data = getLocalJSONData(using: apiData) {
                return data
            }

            throw error
        }
    }

    // MARK: - Private Methods
    /// Attempts to load local fallback JSON data for the given API data.
    /// - Parameter apiData: The API endpoint configuration conforming to APIProtocol.
    /// - Returns: The contents of the fallback JSON file as `Data`, or `nil` if not found.
    private func getLocalJSONData(using apiData: T) -> Data? {
        if let fallbackJson = apiData.fallbackJSONFile,
           let path = Bundle.main.path(forResource: fallbackJson, ofType: "json"),
           let fallbackData = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            return fallbackData
        }

        return nil
    }
}

// MARK: - NetworkExecutor
extension URLSession: NetworkExecutorProtocol {}
