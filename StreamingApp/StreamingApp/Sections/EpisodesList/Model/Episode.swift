//
//  Episode.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 04/04/25.
//

struct Episode: Codable, Identifiable {
    var id: String?
    var title: String?
    var description: String?
    var videoURL: String?
    var duration: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, description, duration
        case videoURL = "videoUrl"
    }
}
