//
//  APIProtocol.swift
//  AppNetwork
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

import Foundation

public enum HTTPMethod: String, Sendable {
    /// HTTP GET method.
    case get = "GET"
    /// HTTP POST method.
    case post = "POST"
    /// HTTP PUT method.
    case update = "PUT"
    /// HTTP DELETE method.
    case delete = "DELETE"
}

/// Protocol defining the requirements for an API endpoint.
public protocol APIProtocol: Sendable {
    /// The base URL for the API.
    var baseURL: String { get }
    /// The path component to be appended to the base URL.
    var path: String { get }
    /// HTTP headers to include in the request.
    var headers: [String: String] { get }
    /// Query parameters to include in the URL.
    var queryParameters: [URLQueryItem]? { get }
    /// HTTP method to use for the request.
    var method: HTTPMethod { get }
    /// Timeout interval for the request.
    var timeoutInterval: TimeInterval { get }
    /// Cache policy for the request.
    var cachePolicy: URLRequest.CachePolicy { get }
    /// Optional local JSON file name for fallback responses.
    var fallbackJSONFile: String? { get }
}

public extension APIProtocol {
    /// Default HTTP headers for the request.
    var headers: [String: String] { ["Accept" : "application/json"] }
    /// Default HTTP method for the request.
    var method: HTTPMethod { .get }
    /// Default query parameters for the request.
    var queryParameters: [URLQueryItem]? { nil }
    /// Default timeout interval for the request.
    var timeoutInterval: TimeInterval { 15 }
    /// Default cache policy for the request.
    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
    /// Default local JSON file name for fallback responses
    var fallbackJSONFile: String? { nil }

    private func getURL() -> URL? {
        guard var components = URLComponents(string: baseURL) else { return nil }

        components.path = path.starts(with: "/") ? path : "/" + path
        components.queryItems = queryParameters

        return components.url
    }

    internal func buildURLRequest(requestBody: Data? = nil) throws -> URLRequest {
        guard let url = getURL() else { throw NetworkError.invalidURL }

        var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        urlRequest.httpBody = requestBody
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers

        return urlRequest
    }
}
