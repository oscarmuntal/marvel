//
//  CharactersModels.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import Foundation

struct MarvelResponse: Codable {
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
    let comics: SectionStructure
    let series: SectionStructure
    let stories: SectionStructure
    let events: SectionStructure
    let urls: [Url]
}

extension Character {
    var toCellViewModel: CharacterCellViewModel {
        .init(id: id, name: name, profileImageUrl: URL(string: thumbnail.path + "." + thumbnail.thumbnailExtension))
    }
}

struct SectionStructure: Codable {
    let available: Int
    let collectionURI: String
    let items: [SectionItem]
}

struct SectionItem: Codable {
    let resourceURI: String
    let name: String
}

struct Url: Codable {
    let type: UrlTitle
    let url: String
}

enum UrlTitle: String, Codable {
    case detail
    case wiki
    case comiclink
    
    var title: String {
        switch self {
        case .detail: return "Detail"
        case .wiki: return "Wiki"
        case .comiclink: return "Comic Link"
        }
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
