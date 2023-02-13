//
//  CharactersRouterMock.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 13/2/23.
//

@testable import Marvel

class CharactersRouterMock: CharactersRouterContract {
    var didSelectItemCalled = false
    var selectedItem: Int?
    
    func didSelect(item: Int) {
        didSelectItemCalled = true
        selectedItem = item
    }
}
