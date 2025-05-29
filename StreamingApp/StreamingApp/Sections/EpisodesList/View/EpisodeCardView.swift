//
//  EpisodeCardView.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 29/05/25.
//

import SwiftUI

struct EpisodeCardView: View {

    // MARK: - Properties
    let episode: Episode

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(episode.title ?? "Episode")
                    .font(.title2)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .foregroundColor(.accentColor)
        }
        .padding(16)
        .background(Color.episodeCardBG)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
