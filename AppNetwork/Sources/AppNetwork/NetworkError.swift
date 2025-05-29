//
//  NetworkError.swift
//  AppNetwork
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case requestFailed(data: Data, triedLocalJson: Bool)
}
