//
//  MockAPI.swift
//  AppNetwork
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

import AppNetwork

struct MockAPI: APIProtocol {
    var baseURL: String = "https://example.com"
    var path: String = "/test"
    var method: HTTPMethod = .post
    var headers: [String : String] = ["Content-Type": "application/json"]
    var queryParameters: [URLQueryItem]? = [URLQueryItem(name: "id", value: "123")]
    var timeoutInterval: TimeInterval = 10
    var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
}
