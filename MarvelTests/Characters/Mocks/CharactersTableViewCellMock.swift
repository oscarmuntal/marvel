//
//  CharactersTableViewCellMock.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 20/2/23.
//

import UIKit
@testable import Marvel

class CharactersTableViewCellMock: CharactersTableViewCell {
    var configureWasCalled = false
    var configureViewModel: CharacterCellViewModel?
    
    override func configure(with viewModel: CharacterCellViewModel) {
        configureWasCalled = true
        configureViewModel = viewModel
        name = UILabel()
        name.text = viewModel.name
        characterId = viewModel.id
    }
}
