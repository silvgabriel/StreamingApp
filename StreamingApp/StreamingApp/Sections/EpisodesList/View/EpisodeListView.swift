//
//  EpisodeListView.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 04/04/25.
//

import SwiftUI

struct EpisodeListView: View {

    // MARK: - Properties
    var viewModel = EpisodeListViewModel()
    @State private var selectedEpisode: Episode?
    @State private var showAlertError: Bool = false
    @Namespace private var animation

    var body: some View {
        ScrollView(showsIndicators: false, content: content)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(Color.textColor)
            .background(Color.episodeListBG)
            .showLoading(when: viewModel.requestState == .inProgress, name: String(format: "loading.title".localized, "episodes"))
            .task {
                await viewModel.fetchEpisodeList()
            }
            .onChange(of: viewModel.requestState) {
                if case .failed = viewModel.requestState {
                    showAlertError = true
                }
            }
            .alert(isPresented: $showAlertError) {
                let button = Alert.Button.default(Text("tryAgain")) {
                    Task {
                        showAlertError = false
                        await viewModel.fetchEpisodeList()
                    }
                }

                return Alert(title: Text("request.failed"), dismissButton: button)
            }
            .sheet(item: $selectedEpisode) { episode in
                let viewModel = EpisodeDetailViewModel(episode: episode)
                EpisodeDetailView(animation: animation, viewModel: viewModel)
            }
    }

    private func content() -> some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            Text("episodeList.title")
                .font(.system(size: 34, weight: .bold))
                .padding(.bottom, 16)

            ForEach(viewModel.episodes, id: \.id) { episode in
                EpisodeCardButtonView(episode: episode, animation: animation) {
                    selectedEpisode = episode
                }
                .matchedTransitionSource(id: episode.title, in: animation)
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Preview
#Preview {
    EpisodeListView(viewModel: .mock)
}
