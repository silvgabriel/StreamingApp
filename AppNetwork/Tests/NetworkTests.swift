//
//  NetworkTests.swift
//  AppNetwork
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

@testable import AppNetwork
import Testing

struct NetworkTests {

    // MARK: - Tests
    @Test
    func buildURLRequestWithQueryItemsAndHeaders() throws {
        let api = MockAPI()
        let request = try api.buildURLRequest()

        #expect(request.url?.absoluteString.contains("id=123") == true)
        #expect(request.httpMethod == "POST")
        #expect(request.allHTTPHeaderFields?["Content-Type"] == "application/json")
        #expect(request.timeoutInterval == 10)
        #expect(request.cachePolicy == .reloadIgnoringLocalAndRemoteCacheData)
    }

    @Test
    func requestWithSuccess() async throws {
        let expectedData = try JSONEncoder().encode(["message": "ok"])

        let executor = MockExecutor()
        executor.mockData = expectedData
        executor.mockResponse = HTTPURLResponse(
            url: URL(string: "https://example.com") ?? URL(fileURLWithPath: ""),
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let service = NetworkService<MockAPI>(executor: executor)
        let data = try await service.request(MockAPI())

        let decoded = try JSONDecoder().decode([String: String].self, from: data)
        #expect(decoded["message"] == "ok")
    }

    @Test
    func requestWithStatusCode400() async {
        let errorData = try? JSONEncoder().encode(["error": "bad request"])

        let executor = MockExecutor()
        executor.mockData = errorData ?? Data()
        executor.mockResponse = HTTPURLResponse(
            url: URL(string: "https://example.com") ?? URL(fileURLWithPath: ""),
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )

        let service = NetworkService<MockAPI>(executor: executor)

        do {
            _ = try await service.request(MockAPI())
            Issue.record("Expected to throw NetworkError")
        } catch let NetworkError.requestFailed(data, _) {
            let decoded = try? JSONDecoder().decode([String: String].self, from: data)
            #expect(decoded?["error"] == "bad request")
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
}
