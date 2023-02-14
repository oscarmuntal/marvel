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

