//
//  Int+ExtensionTests.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

@testable import StreamingApp
import Testing

struct IntExtensionTests {

    // MARK: - Tests
    @Test
    func formattedTimeWithZeroSeconds() {
        let time = 0

        #expect(time.formattedTime == "00:00")
    }

    @Test
    func formattedTimeWithSecondsOnly() {
        let time = 45

        #expect(time.formattedTime == "00:45")
    }

    @Test
    func formattedTimeWithMinutesAndSeconds() {
        let time = 125

        #expect(time.formattedTime == "02:05")
    }

    @Test
    func formattedTimeWithWholeMinutes() {
        let time = 600

        #expect(time.formattedTime == "10:00")
    }
}
