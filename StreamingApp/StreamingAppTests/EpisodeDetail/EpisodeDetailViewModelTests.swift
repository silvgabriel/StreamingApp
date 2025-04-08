//
//  EpisodeDetailViewModelTests.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

import AVKit
import Foundation
@testable import StreamingApp
import Testing

struct EpisodeDetailViewModelTests {

    // MARK: - Tests
    @Test
    func initSetsEpisodeCorrectly() {
        let episode = Episode(
            id: "123",
            title: "Title",
            description: "Description",
            videoURL: "https://example.com/video.mp4",
            duration: 120
        )

        let viewModel = EpisodeDetailViewModel(episode: episode)

        #expect(viewModel.episode.id == "123")
        #expect(viewModel.episode.title == "Title")
        #expect(viewModel.episode.description == "Description")
        #expect(viewModel.episode.videoURL == "https://example.com/video.mp4")
        #expect(viewModel.episode.duration == 120)
    }

    @Test
    func setupPlayerSetsPlayerWithCorrectURL() async {
        let videoURL = "https://example.com/video.mp4"

        let episode = Episode(
            id: "1",
            title: "Video",
            description: "",
            videoURL: videoURL,
            duration: 10
        )

        let viewModel = EpisodeDetailViewModel(episode: episode)
        await viewModel.setupPlayer()

        let expectedURL = URL(string: videoURL)
        let avPlayerURL = await (viewModel.player?.currentItem?.asset as? AVURLAsset)?.url

        #expect(avPlayerURL == expectedURL)
    }

    @Test
    func setupPlayerWithInvalidURL() async {
        let episode = Episode(
            id: "1",
            title: "Video",
            description: "",
            videoURL: "h`tp:/test/com",
            duration: 10
        )

        let viewModel = EpisodeDetailViewModel(episode: episode)
        await viewModel.setupPlayer()

        #expect(viewModel.player == nil)
        #expect(viewModel.playerStatus == .failed)
    }
}
