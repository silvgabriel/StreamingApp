//
//  EpisodeListViewModelTests.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

import AppNetwork
@testable import StreamingApp
import Testing

struct EpisodeListViewModelTest {

    // MARK: - Tests
    @Test
    func fetchEpisodeListWithSuccess() async {
        let mockExecutor = NetworkExecutorMock()

        let testEpisodes = [
            Episode(id: "1", title: "Episode 1"),
            Episode(id: "2", title: "Episode 2")
        ]

        let mockedData = try? JSONEncoder().encode(testEpisodes)
        mockExecutor.mockedData = mockedData ?? Data()
        mockExecutor.mockedStatusCode = 200

        let viewModel = EpisodeListViewModel(service: NetworkService(executor: mockExecutor))
        await viewModel.fetchEpisodeList()

        await #expect(viewModel.requestState == .success)
        await #expect(viewModel.episodes.count == 2)
        await #expect(viewModel.episodes.first?.title == "Episode 1")
        await #expect(viewModel.episodes.last?.title == "Episode 2")
    }

    @Test
    func fetchEpisodeListWithFailureAndLoadJSON() async {
        let mockExecutor = NetworkExecutorMock()
        mockExecutor.mockedError = URLError(.badServerResponse)

        let viewModel = EpisodeListViewModel(service: NetworkService(executor: mockExecutor))

        await viewModel.fetchEpisodeList()

        await #expect(viewModel.requestState == .success)
        await #expect(viewModel.episodes.isEmpty == false)
    }

    @Test
    func fetchEpisodeListWithFailure() async {
        let mockExecutor = NetworkExecutorMock()
        mockExecutor.mockedError = URLError(.badServerResponse)

        let viewModel = EpisodeListViewModel(service: NetworkService(executor: mockExecutor))

        await viewModel.fetchEpisodeList(loadLocalJsonIfNecessary: false)

        await #expect(viewModel.requestState == .failed("request.failed".localized))
        await #expect(viewModel.episodes.isEmpty == true)
    }
}
