//
//  HelperMethods.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 13/2/23.
//

import Foundation
@testable import Marvel

// MARK: - Helpers
func defaultResponse() -> MarvelResponse {
    MarvelResponse(copyright: "copyright: Òscar Muntal 2023", attributionText: "", data: defaultCharactersData())
}

func defaultCharactersData() -> CharactersData {
    CharactersData(offset: 0, limit: 0, total: 0, count: 13, results: [])
}

func defaultCharacter(id: Int = 0, name: String = "") -> Character {
    let characterName = name != "" ? name : "Character \(id)"
    return Character(id: id, name: characterName, description: "Description \(id)", thumbnail: Thumbnail(path: "path/to/thumbnail1", thumbnailExtension: "jpg"), comics: emptySectionStructure(), series: emptySectionStructure(), stories: emptySectionStructure(), events: emptySectionStructure(), urls: [])
}

func emptySectionStructure() -> SectionStructure {
    SectionStructure(available: 0, collectionURI: "", items: [])
}

func ironmanCharacter() -> Character {
    Character(id: 123, name: "Iron Man", description: "Iron Man description", thumbnail: Thumbnail(path: "path/to/thumbnail1", thumbnailExtension: "jpg"), comics: emptySectionStructure(), series: emptySectionStructure(), stories: emptySectionStructure(), events: emptySectionStructure(), urls: [])
}
