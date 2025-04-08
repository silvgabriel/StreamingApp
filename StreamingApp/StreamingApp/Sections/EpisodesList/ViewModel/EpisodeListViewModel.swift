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
            // API is down again, so I implemented a local json for backup
            if loadLocalJsonIfNecessary, let path = Bundle.main.path(forResource: "response_mock", ofType: "json") {
                let mockedData = try? Data(contentsOf: URL(fileURLWithPath: path))
                let decodedData = try? [Episode].decoded(from: mockedData ?? Data())

                await MainActor.run {
                    episodes = decodedData ?? []
                    requestState = .success
                }
            } else {
                await MainActor.run {
                    requestState = .failed("request.failed".localized)
                }
            }
        }
    }
}
