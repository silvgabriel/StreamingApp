//
//  EpisodeListViewModel.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 04/04/25.
//

import AppNetwork
import Observation

@Observable
class EpisodeListViewModel {

    // MARK: - Properties
    private let service: NetworkService<StreamingAPI>
    @MainActor private(set) var episodes: [Episode] = []
    @MainActor private(set) var requestState = RequestState.inProgress

    #if DEBUG
    static var mock: EpisodeListViewModel {
        let mockExecutor = NetworkExecutorMock()
        mockExecutor.mockedStatusCode = 404

        return EpisodeListViewModel(service: NetworkService(executor: mockExecutor))
    }
    #endif

    init(service: NetworkService<StreamingAPI> = NetworkService()) {
        self.service = service
    }

    // MARK: - Public Methods
    func fetchEpisodeList(loadLocalJsonIfNecessary: Bool = true) async {
        await MainActor.run {
            requestState = .inProgress
        }

        do {
            let responseData = try await service.request(.getList)
            let decodedData: [Episode] = try [Episode].decoded(from: responseData)

            await MainActor.run {
                episodes = decodedData
                requestState = .success
            }
        } catch {
            await MainActor.run {
                requestState = .failed("request.failed".localized)
            }
        }
    }
}
