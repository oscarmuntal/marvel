//
//  CharactersModels.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import Foundation

struct Response: Codable {
    let copyright: String
    let attributionText: String
    let data: CharactersData
}

struct CharactersData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
}

extension Character {
    var toCellViewModel: CharacterCellViewModel {
        .init(id: id, name: name, profileImageUrl: URL(string: thumbnail.path + "." + thumbnail.thumbnailExtension))
    }
}

struct Thumbnail: Codable {
    enum CodingKeys: String, CodingKey {
        case thumbnailExtension = "extension"
        case path
    }
    let path: String
    let thumbnailExtension: String
}
