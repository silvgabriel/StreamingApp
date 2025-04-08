//
//  NetworkMock.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 04/04/25.
//

#if DEBUG
import AppNetwork

class NetworkExecutorMock: NetworkExecutorProtocol {

    // MARK: - Properties
    var mockedData = Data()
    var mockedError: Error?
    var mockedStatusCode = 200

    // MARK: - Public Methods
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let mockedError {
            throw mockedError
        }

        guard let requestUrl = request.url else { return (Data(), URLResponse()) }

        let urlResponse = HTTPURLResponse(
            url: requestUrl,
            statusCode: mockedStatusCode,
            httpVersion: nil,
            headerFields: nil
        )

        return (mockedData, urlResponse ?? URLResponse())
    }
}
#endif
