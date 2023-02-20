//
//  CharactersPresenterMock.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 20/2/23.
//

import Foundation
@testable import Marvel

class CharactersPresenterMock: CharactersPresenterContract {
    var view: CharactersViewContract?
    var numCharactersCalled = false
    var numCharactersReturnValue = 0
    var cellViewModelCalled = false
    var cellViewModelReturnValue: CharacterCellViewModel?
    var cellViewModelIndexPath: IndexPath?
    var didSelectItemCalled = false
    var didSelectItemIndexPath: IndexPath?
    var didScrollCalled = false
    var isPaginatingCalled = false
    var isPaginatingReturnValue = false
    
    
    func numCharacters() -> Int {
        numCharactersCalled = true
        return numCharactersReturnValue
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CharacterCellViewModel {
        cellViewModelCalled = true
        cellViewModelIndexPath = indexPath
        return cellViewModelReturnValue!
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        didSelectItemCalled = true
        didSelectItemIndexPath = indexPath
    }
    
    func didScroll() {
        didScrollCalled = true
    }
    
    
    func isPaginating() -> Bool {
        isPaginatingCalled = true
        return isPaginatingReturnValue
    }
}
