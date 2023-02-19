//
//  CharactersTableViewCell.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var name: UILabel!
    public var characterId: Int!
    
    func configure(with viewModel: CharacterCellViewModel) {
        profileImage.setCharacterImage(with: viewModel.profileImageUrl)
        profileImage.rounded()
        name.text = viewModel.name
        characterId = viewModel.id
    }
}
