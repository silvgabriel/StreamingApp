//
//  APIProtocol.swift
//  AppNetwork
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

import Foundation

public enum HTTPMethod: String, Sendable {
    case get = "GET"
    case post = "POST"
    case update = "PUT"
    case delete = "DELETE"
}

public protocol APIProtocol: Sendable {
    var baseURL: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var queryParameters: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
    var timeoutInterval: TimeInterval { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

public extension APIProtocol {
    var headers: [String: String] { ["Accept" : "application/json"] }
    var method: HTTPMethod { .get }
    var queryParameters: [URLQueryItem]? { nil }
    var timeoutInterval: TimeInterval { 15 }
    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }

    private func getURL() -> URL? {
        let urlString = "\(baseURL)\(path.starts(with: "/") ? "\(path)" : "/\(path)")"

        if let queryParameters {
            return URL(string: urlString)?.appending(queryItems: queryParameters)
        } else {
            return URL(string: urlString)
        }
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
