//
//  CharactersViewMock.swift
//  MarvelTests
//
//  Created by Òscar Muntal on 13/2/23.
//

import UIKit
@testable import Marvel

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
