//
//  String+ExtensionTests.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

@testable import StreamingApp
import Testing

struct StringExtensionTest {

    // MARK: - Tests
    @Test
    func localizedStringReturnsExpectedKey() {
        let keys: [String] = [
            // MARK: - Common
            String(format: "loading.title".localized, "video"),
            "video.loading.failed",

            // MARK: - Episode list
            "episodeList.title",

            // MARK: - Episode Detail
            "episodeDetail.description.title",
            "episodeDetail.duration.title",
            "episodeDetail.unavailable.description",
            "episodeDetail.unavailable.duration"
        ]

        let expectedStrings = [
            // MARK: - Common
            "Loading video...",
            "Failed to load video",

            // MARK: - Episode list
            "Episodes",

            // MARK: - Episode Detail
            "Description",
            "Duration",
            "No description available",
            "No duration available"
        ]

        for (stringKey, expectedString) in zip(keys, expectedStrings) {
            #expect(stringKey.localized == expectedString)
        }
    }
}
