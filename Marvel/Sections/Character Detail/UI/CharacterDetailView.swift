//
//  CharacterDetailView.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import UIKit
import Alamofire

class CharacterDetailView: UIViewController, CreatableView, CharacterDetailViewContract {
    var presenter: CharacterDetailPresenterContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
    }
}
