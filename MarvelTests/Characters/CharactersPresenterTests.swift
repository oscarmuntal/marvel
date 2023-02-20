//
//  CharactersPresenterTests.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 11/2/23.
//

import XCTest
import UIKit
import Combine
@testable import Marvel

class CharactersPresenterTests: XCTestCase {
    private var presenter: CharactersPresenter!
    private var view: CharactersViewMock!
    private var interactor: CharactersInteractorMock!
    private var wireframe: CharactersWireframeMock!
    private var router: CharactersRouterMock!
    
    override func setUp() {
        view = CharactersViewMock()
        interactor = CharactersInteractorMock()
        wireframe = CharactersWireframeMock()
        router = CharactersRouterMock()
        presenter = CharactersPresenter(wireframe: wireframe, interactor: interactor, router: router)
    }
    
    func testNumCharacters() {
        // given
        let charactersData = CharactersData(offset: 0, limit: 20, total: 100, count: 20, results: [
            defaultCharacter(id: 1),
            defaultCharacter(id: 2),
            defaultCharacter(id: 3)
        ])
        let response = MarvelResponse(copyright: "Copyright", attributionText: "Attribution Text", data: charactersData)
        presenter.characters = response.data.results
        
        // when
        let numberOfCharacters = presenter.numCharacters()
        
        // then
        XCTAssertEqual(numberOfCharacters, 3, "The number of characters should be equal to 3")
    }
    
    func testCellViewModel() {
        // given
        presenter.characters = [ironmanCharacter()]
        let indexPath = IndexPath(row: 0, section: 0)
        
        // when
        let cellViewModel = presenter.cellViewModel(at: indexPath)
        
        // then
        XCTAssertEqual(cellViewModel.name, "Iron Man")
        XCTAssertEqual(cellViewModel.profileImageUrl, URL(string: "path/to/thumbnail1.jpg"))
    }
    
    func testDidSelectItem() {
        // given
        presenter.characters = [ironmanCharacter()]
        let indexPath = IndexPath(row: 0, section: 0)
        
        // when
        presenter.didSelectItem(at: indexPath)
        
        // then
        XCTAssertTrue(router.didSelectItemCalled)
        XCTAssertEqual(router.selectedItem, 123)
    }
    
    func testDidScroll() {
        // when
        presenter.view = view
        presenter.didScroll()
        
        // then
        DispatchQueue.main.async {
            XCTAssertTrue(self.view.configureTableFooterCalled)
        }
        XCTAssertTrue(interactor.fetchCharactersCalled)
        XCTAssertEqual(interactor.offset, "0")
    }
    
    func testIsPaginating() {
        // given
        presenter.view = view
        presenter.didScroll()

        // when
        let isPaginating = presenter.isPaginating()

        // then
        XCTAssertTrue(isPaginating)
    }
    
    func testLoadCharacters1() {
        // when
        presenter.view = view
        
        // then
        DispatchQueue.main.async {
            XCTAssertTrue(self.view.configureTableFooterCalled)
        }
        XCTAssertTrue(interactor.fetchCharactersCalled)
        XCTAssertEqual(presenter.currentPage, 0)
        XCTAssertEqual(presenter.offset, "0")
    }
}

