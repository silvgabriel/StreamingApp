//
//  StreamingAPI.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 04/04/25.
//

import AppNetwork

enum StreamingAPI: APIProtocol {
    case getList

    var baseURL: String {
        "https://run.mocky.io"
    }

    var path: String {
        "/v3/32195a4b-e6e5-4165-8b48-20fd995c1e43"
    }

}
