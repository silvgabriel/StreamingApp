//
//  EpisodeListView.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 04/04/25.
//

import AppNetwork
import SwiftUI

struct EpisodeListView: View {

    // MARK: - Properties
    var viewModel = EpisodeListViewModel()
    @State private var selectedEpisode: Episode?
    @State private var showAlertError: Bool = false
    @Namespace private var animation

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                Text("episodeList.title")
                    .font(.largeTitle)
                    .padding(.bottom, 16)

                ForEach(viewModel.episodes, id: \.id) { episode in
                    episodeCard(episode)
                        .matchedTransitionSource(id: episode.title, in: animation)
                        .onTapGesture {
                            selectedEpisode = episode
                        }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundStyle(Color.textColor)
        .background(Color.episodeListBG)
        .fontWeight(.semibold)
        .showLoading(when: viewModel.requestState == .inProgress, name: String(format: "loading.title".localized, "episodes"))
        .task {
            guard viewModel.episodes.isEmpty else { return }
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

    // MARK: - Private Method
    private func episodeCard(_ episode: Episode ) -> some View {
        HStack {
            Text(episode.title ?? episode.description ?? "Episode")
                .font(.title2)

            Spacer()

            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 32)
                .fontWeight(.regular)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .background(Color.episodeCardBG)
        .roundedCorners(16)
    }
}

// MARK: - Preview
#Preview {
    EpisodeListView(viewModel: .mock)
}
