//
//  ExtensionTests.swift
//  AppNetwork
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

@testable import AppNetwork
import Testing

struct ExtensionTests {

    // MARK: - Tests
    @Test
    func testEncodeAndDecode() throws {
        struct User: Codable, Equatable {
            let name: String
        }

        let user = User(name: "Gabriel")
        let data = try user.encoded()
        let decoded = try User.decoded(from: data)

        #expect(decoded == user)
    }

    @Test
    func testArrayEncodeAndDecode() throws {
        struct Book: Codable, Equatable {
            let title: String
        }

        let books = [Book(title: "A"), Book(title: "B")]
        let data = try books.encoded() ?? Data()
        let decoded = try JSONDecoder().decode([Book].self, from: data)

        #expect(decoded == books)
    }

    @Test
    func testResponseIsSuccess() {
        let successResponse = HTTPURLResponse(
            url: URL(string: "https://test.com") ?? URL(fileURLWithPath: ""),
            statusCode: 204,
            httpVersion: nil,
            headerFields: nil
        )

        let failureResponse = HTTPURLResponse(
            url: URL(string: "https://test.com") ?? URL(fileURLWithPath: ""),
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )

        #expect(successResponse?.isSuccess() == true)
        #expect(failureResponse?.isSuccess() == false)
    }
}
