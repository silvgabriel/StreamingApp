//
//  EpisodeDetailViewModel.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 05/04/25.
//

import AVKit
import Foundation

@Observable
class EpisodeDetailViewModel {

    // MARK: - Properties
    let episode: Episode
    private(set) var playerStatusObserver: NSKeyValueObservation?
    private(set) var player: AVPlayer?
    private(set) var playerStatus: AVPlayerItem.Status?

    #if DEBUG
    static var mock: EpisodeDetailViewModel {
        let episode = Episode(
            id: "1",
            title: "Big Buck Bunny",
            description: "This is the first sample video.",
            videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            duration: 596
        )

        return EpisodeDetailViewModel(episode: episode)
    }
    #endif

    // MARK: - Initializers
    init(episode: Episode) {
        self.episode = episode
    }

    deinit {
        playerStatusObserver?.invalidate()
        playerStatusObserver = nil

        player?.pause()
        player = nil
    }

    // MARK: - Public Methods
    func setupPlayer() async {
        if let urlString = episode.videoURL, let videoURL = URL(string: urlString) {
            let asset = AVURLAsset(url: videoURL)
            _ = try? await asset.load(.isPlayable)
            _ = try? await asset.load(.tracks, .duration, .preferredTransform)

            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
            try? AVAudioSession.sharedInstance().setActive(true)

            player = AVPlayer(playerItem: AVPlayerItem(asset: asset))
            setupObservers()
            player?.play()
        } else {
            playerStatus = .failed
        }
    }

    // MARK: - Private Methods
    private func setupObservers() {
        playerStatusObserver = player?.currentItem?.observe(\.status, options: [.new]) { [weak self] item, _ in
            self?.playerStatus = item.status
        }
    }
}
