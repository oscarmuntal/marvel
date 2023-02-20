//
//  CharacterDetailBuilderTests.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 20/2/23.
//

import XCTest
@testable import Marvel

class CharacterDetailBuilderTests: XCTestCase {
    var wireframe: CharacterDetailWireframe!
    var builder: CharacterDetailBuilder!
    
    override func setUp() {
        super.setUp()
        wireframe = CharacterDetailWireframeMock()
    }
    
    override func tearDown() {
        wireframe = nil
        super.tearDown()
    }
    
    func testBuildViewController() {
        // Given
        let characterId = 111
        let builder = CharacterDetailBuilder(wireframe: wireframe, characterId: characterId)
        
        // When
        let viewController = builder.buildViewController()
        
        // Then
        XCTAssertNotNil(viewController)
    }
    
    func testBuilPresenter() {
        // Given
        let characterId = 222
        let builder = CharacterDetailBuilder(wireframe: wireframe, characterId: characterId)
        
        // When
        let presenter = builder.buildPresenter()
        
        // Then
        XCTAssertNotNil(presenter)
    }
}

