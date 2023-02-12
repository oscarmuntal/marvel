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
    
    //MARK: - Tests
    
    func testNumCharacters() {
        // given
        let charactersData = CharactersData(offset: 0, limit: 20, total: 100, count: 20, results: [
            defaultCharacter(id: 1),
            defaultCharacter(id: 2),
            defaultCharacter(id: 3)
        ])
        let response = Response(copyright: "Copyright", attributionText: "Attribution Text", data: charactersData)
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
        XCTAssertTrue(view.configureTableFooterCalled)
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
        XCTAssertTrue(view.configureTableFooterCalled)
        XCTAssertTrue(interactor.fetchCharactersCalled)
        XCTAssertEqual(presenter.currentPage, 0)
        XCTAssertEqual(presenter.offset, "0")
    }
}


// MARK: - Mocks

class CharactersViewMock: UIViewController, CharactersViewContract, Presentable {
    var configureTableFooterCalled = false
    var showErrorAlertCalled = false
    var reloadCalled = false
    
    func configureTableFooter() {
        configureTableFooterCalled = true
    }
    
    func showErrorAlert(withTitle title: String, withMessage message: String) {
        showErrorAlertCalled = true
    }
    
    func reload() {
        reloadCalled = true
    }
    
    func errorAlertAction() -> UIAlertAction {
        return UIAlertAction(title: "Ok", style: .default, handler: nil)
    }
}

class CharactersInteractorMock: CharactersInteractorContract {
    var fetchCharactersCalled = false
    var offset = ""
    
    func fetchCharacters(offset: String) -> AnyPublisher<Response, MarvelError> {
        fetchCharactersCalled = true
        self.offset = offset
        return Empty().eraseToAnyPublisher()
    }
}


//class CharactersInteractorMock2: CharactersInteractorContract {
//    var fetchCharactersCalled = false
//    var offset = ""
//
//    func fetchCharacters(offset: String) -> AnyPublisher<Response, MarvelError> {
//        fetchCharactersCalled = true
//        self.offset = offset
//        let characters = [
//            defaultCharacter(id: 1011334, name: "3-D Man"),
//            defaultCharacter(id: 1017100, name: "A-Bomb (HAS)"),
//            defaultCharacter(id: 1009144, name: "A.I.M."),
//            defaultCharacter(id: 1009146, name: "Aaron Stack"),
//            defaultCharacter(id: 1009148, name: "Abomination (Emil Blonsky)")
//        ]
//        let data = CharactersData(offset: 0, limit: 0, total: characters.count, count: characters.count, results: characters)
//        let response = Response(copyright: "", attributionText: "", data: data)
//        return Result.success(response)
//            .publisher
//            .mapError { _ in MarvelError }
//            .eraseToAnyPublisher()
//    }
//}


class CharactersWireframeMock: CharactersWireframe {
    var openCharacterDetailCalled = false
    var id: Int = 0
    
    func openCharacterDetail(with id: Int) {
        openCharacterDetailCalled = true
        self.id = id
    }
}

class CharactersRouterMock: CharactersRouterContract {
    var didSelectItemCalled = false
    var selectedItem: Int?
    
    func didSelect(item: Int) {
        didSelectItemCalled = true
        selectedItem = item
    }
}


// MARK: - Helpers

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
