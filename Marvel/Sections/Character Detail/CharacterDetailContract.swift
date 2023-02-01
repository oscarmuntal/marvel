//
//  CharacterDetailContract.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation
import Alamofire

protocol CharacterDetailWireframe {}

protocol CharacterDetailViewContract {}

protocol CharacterDetailPresenterContract {
    var view: CharacterDetailViewContract? { get set }
}

protocol CharacterDetailInteractorContract {}
