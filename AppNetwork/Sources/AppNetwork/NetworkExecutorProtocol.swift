//
//  NetworkExecutor.swift
//  AppNetwork
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

import Foundation

public protocol NetworkExecutorProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
