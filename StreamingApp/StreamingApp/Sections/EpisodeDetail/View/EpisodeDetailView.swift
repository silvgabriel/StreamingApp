//
//  EpisodeDetailView.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 05/04/25.
//

import AVKit
import SwiftUI

struct EpisodeDetailView: View {

    // MARK: - Properties
    let animation: Namespace.ID
    @State var viewModel: EpisodeDetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            if let title = viewModel.episode.title {
                Text(title)
                    .font(.largeTitle)
            }

            VStack(alignment: .leading, spacing: 16) {
                let description = viewModel.episode.description ?? "episodeDetail.unavailable.description"
                infoView(title: "episodeDetail.description.title", value: LocalizedStringKey(description))

                let duration = viewModel.episode.duration?.formattedTime ?? "episodeDetail.unavailable.duration"
                infoView(title: "episodeDetail.duration.title", value: LocalizedStringKey(duration))
            }

            VideoPlayer(player: viewModel.player)
                .aspectRatio(16 / 9, contentMode: .fit)
                .showLoading(when: viewModel.playerStatus == nil, name: String(format: "loading.title".localized, "video"))
                .outlined(radius: 0, lineWidth: 2, color: Color.textColor)
                .onAppear {
                    Task {
                        await viewModel.setupPlayer()
                    }
                }
                .overlay(alignment: .bottom) {
                    if viewModel.playerStatus == .failed || viewModel.playerStatus == .unknown {
                        Text("video.loading.failed")
                            .padding(.bottom, 32)
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 16)
        .font(.title3)
        .background(Color.episodeDetailBG)
        .foregroundStyle(Color.textColor)
        .navigationTransition(.zoom(sourceID: viewModel.episode.title, in: animation))
    }

    // MARK: - Private Methods
    private func infoView(title: LocalizedStringKey, value: LocalizedStringKey) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)

            Text(value)
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Namespace var animation

    EpisodeDetailView(animation: animation, viewModel: .mock)
}
