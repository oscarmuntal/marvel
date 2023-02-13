//
//  CharactersBuilderTests.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 13/2/23.
//

import XCTest
@testable import Marvel

class CharactersBuilderTests: XCTestCase {
    
    var charactersBuilder: CharactersBuilder!
    var wireframe: CharactersWireframeMock!
    
    override func setUp() {
        super.setUp()
        wireframe = CharactersWireframeMock()
        charactersBuilder = CharactersBuilder(wireframe: wireframe)
    }
    
    override func tearDown() {
        wireframe = nil
        charactersBuilder = nil
        super.tearDown()
    }
    
    func testBuildViewController() {
        // given
        let charactersView = charactersBuilder.buildViewController()
        
        // then
        XCTAssertNotNil(charactersView, "Expected non-nil view controller")
        XCTAssertTrue(charactersView is CharactersView, "Expected view controller to be of type CharactersView")
    }
    
    func testBuildViewController2() {
        // given
        guard let charactersView = charactersBuilder.buildViewController() as? CharactersView else { return }
        
        // when
        let presenter = charactersView.presenter
        
        // then
        XCTAssertNotNil(presenter, "Expected non-nil presenter")
        XCTAssertTrue(presenter is CharactersPresenter, "Expected presenter to be of type CharactersPresenter")
    }
    
    func testBuildViewController3() {
        // given
        guard   let charactersView = charactersBuilder.buildViewController() as? CharactersView,
                let presenter = charactersView.presenter as? CharactersPresenter else { return }
        
        // then
        XCTAssertTrue(presenter.interactor is CharactersInteractor, "Expected presenter's interactor to be of type CharactersInteractor")
        XCTAssertTrue(presenter.router is CharactersRouter, "Expected presenter's router to be of type CharactersRouter")
    }
}
