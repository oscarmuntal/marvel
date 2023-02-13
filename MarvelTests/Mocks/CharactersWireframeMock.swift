//
//  CharactersWireframeMock.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 13/2/23.
//

@testable import Marvel

class CharactersWireframeMock: CharactersWireframe {
    var openCharacterDetailCalled = false
    var id: Int = 0
    
    func openCharacterDetail(with id: Int) {
        openCharacterDetailCalled = true
        self.id = id
    }
}
