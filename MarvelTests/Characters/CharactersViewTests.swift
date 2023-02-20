//
//  CharactersViewTests.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 11/2/23.
//

import XCTest
@testable import Marvel

class CharactersViewTests: XCTestCase {
    var charactersView: CharactersView!
    var presenter: CharactersPresenterMock!
    var tableView: UITableViewMock!

    override func setUp() {
        super.setUp()
        charactersView = CharactersView.createFromStoryboard()
        presenter = CharactersPresenterMock()
        charactersView.presenter = presenter
        tableView = UITableViewMock()
        charactersView.tableView = tableView
    }

    override func tearDown() {
        charactersView = nil
        presenter = nil
        tableView = nil
        super.tearDown()
    }

    func testNumberOfRowsInSection() {
        // Given
        presenter.numCharactersReturnValue = 5

        // When
        let numberOfRows = charactersView.tableView(tableView, numberOfRowsInSection: 0)

        // Then
        XCTAssertEqual(numberOfRows, 5)
    }

    func testCellForRowAt() {
        // Given
        let cellViewModel = CharacterCellViewModel(id: 123, name: "name", profileImageUrl: nil)
        presenter.cellViewModelReturnValue = cellViewModel
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        let cell = charactersView.tableView(tableView, cellForRowAt: indexPath) as! CharactersTableViewCellMock
        
        // Then
        XCTAssertEqual(cell.characterId, cellViewModel.id)
        XCTAssertEqual(cell.name.text, cellViewModel.name)
    }

    func testDidSelectRowAt() {
        // Given
        let indexPath = IndexPath(row: 0, section: 0)

        // When
        charactersView.tableView(tableView, didSelectRowAt: indexPath)

        // Then
        XCTAssertTrue(presenter.didSelectItemCalled)
        XCTAssertEqual(presenter.didSelectItemIndexPath, indexPath)
    }

    func testScrollViewDidScroll() {
        // Given
        let scrollView = UIScrollView()
        tableView.contentSize.height = 200
        let scrollFrame = CGRect(origin: scrollView.frame.origin, size: CGSize(width: 100, height: 100))
        scrollView.frame = scrollFrame
        scrollView.contentOffset.y = 100
        presenter.isPaginatingReturnValue = false

        // When
        charactersView.scrollViewDidScroll(scrollView)

        // Then
        XCTAssertTrue(presenter.didScrollCalled)
    }
    
    func testConfigureTableFooter() {
        // When
        charactersView.configureTableFooter()
        guard let tableFooterView = charactersView.tableView.tableFooterView else { return }
        
        // Then
        XCTAssertNotNil(tableFooterView, "Table footer view should not be nil")
    }
    
    func testCreateSpinnerFooter() {
        // When
        charactersView.configureTableFooter()
        guard let spinerFooter = charactersView.tableView.tableFooterView else { return }
        
        // Then
        XCTAssertNotNil(spinerFooter, "Spinner footer view should not be nil")
        XCTAssertTrue(spinerFooter.subviews.first is UIActivityIndicatorView, "Spinner footer view should contain a UIActivityIndicatorView")
    }
    
    func testErrorAlertAction() {
        // When
        let errorAlertAction = charactersView.errorAlertAction()
        
        // Then
        XCTAssertNotNil(errorAlertAction, "Error alert action should not be nil")
        XCTAssertEqual(errorAlertAction.title, "OK", "Error alert action title should be OK")
        XCTAssertEqual(errorAlertAction.style, .cancel, "Error alert action style should be .cancel")
    }
    
}




