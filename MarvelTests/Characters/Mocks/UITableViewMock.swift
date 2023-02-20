//
//  UITableViewMock.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 20/2/23.
//

import UIKit
@testable import Marvel

class UITableViewMock: UITableView {
    var reloadDataWasCalled = false
    var dequeueReusableCellWithIdentifierWasCalled = false
    var dequeueReusableCellWithIdentifierIndexPath: IndexPath?

    override func reloadData() {
        reloadDataWasCalled = true
    }
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        dequeueReusableCellWithIdentifierWasCalled = true
        dequeueReusableCellWithIdentifierIndexPath = indexPath
        if identifier == "CharacterCell" {
            return CharactersTableViewCellMock(style: .default, reuseIdentifier: "CharacterCell")
        } else {
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
}
