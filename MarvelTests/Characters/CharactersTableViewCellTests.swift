//
//  CharacterCellViewModelTests.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 13/2/23.
//

import UIKit
import XCTest
@testable import Marvel

class CharactersTableViewCellTests: XCTestCase {
    var cell: CharactersTableViewCell!
    var viewModel: CharacterCellViewModel!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "CharactersView", bundle: Bundle(for: CharactersView.self))
        let controller = storyboard.instantiateViewController(withIdentifier: "CharactersView") as! CharactersView
        controller.loadViewIfNeeded()
        let tableView = controller.tableView
        let indexPath = IndexPath(row: 0, section: 0)
        cell = tableView!.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharactersTableViewCell
        let imageURL = "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04.jpg"
        viewModel = CharacterCellViewModel(id: 1, name: "Abomination", profileImageUrl: URL(string: imageURL))
    }
    
    override func tearDown() {
        cell = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testConfigureWithViewModel_setsProfileImage() {
        // when
        cell.configure(with: viewModel)
        
        // then
        XCTAssertNotNil(cell.profileImage.image)
        let data = try? Data(contentsOf: viewModel.profileImageUrl!)
        let expectedImage = UIImage(data: data!)
        XCTAssertNotNil(expectedImage)
    }
    
    func testConfigureWithViewModel_setsName() {
        // when
        cell.configure(with: viewModel)
        
        // then
        XCTAssertEqual(cell.name.text, viewModel.name)
    }
    
    func testConfigureWithViewModel_setsCharacterId() {
        // when
        cell.configure(with: viewModel)
        
        // then
        XCTAssertEqual(cell.characterId, viewModel.id)
    }
    
    func testSetCharacterImageWithURL() {
        // given
        let profileImage = UIImageView()
        let url = URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04.jpg")!

        // when
        profileImage.setCharacterImage(with: url)

        // then
        XCTAssertNotNil(profileImage.image, "Image should not be nil")
    }
}
