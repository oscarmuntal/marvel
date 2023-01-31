//
//  CharactersModels.swift
//  Marvel
//
//  Created by A on 31/1/23.
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
}

extension Character {
    var toCellViewModel: CharacterCellViewModel {
        .init(id: id, name: name)
    }
}
