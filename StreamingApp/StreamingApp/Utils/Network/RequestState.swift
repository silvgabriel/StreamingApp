//
//  RequestState.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 04/04/25.
//

enum RequestState: Equatable {
    case success
    case inProgress
    case failed(String)
}
