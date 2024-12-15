import Foundation

struct EpisodeResponse: Decodable {
    var results: [Episode]
}

struct CharacterResponse: Decodable {
    var results: [Character]
}

struct Episode: Decodable, Identifiable {
    var id: Int
    var name: String
    var air_date: String
    var episode: String
    var characters: [String]
    var url: String
}

struct Character: Decodable, Identifiable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var gender: String
    var image: String
    var url: String
    var episode: Array<String>
    var origin: Origin
}

struct Origin: Decodable {
    var name: String
    var url: String
}

enum WhatToSearch: String, CaseIterable, Identifiable {
    case episode = "Episodes"
    case character = "Characters"
    
    var id: String { self.rawValue }
}
