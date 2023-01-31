//
//  CharactersView.swift
//  Marvel
//
//  Created by A on 31/1/23.
//

import Foundation
import UIKit

class CharactersView: UIViewController, CreatableView {

    var presenter: CharactersPresenterContract?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
        
    }
}

extension CharactersView: CharactersViewContract {
    
}
