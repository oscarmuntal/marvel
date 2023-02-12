//
//  CharactersTableViewCell.swift
//  Marvel
//
//  Created by Òscar Muntal on 31/1/23.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    public var characterId: Int!
    
    func configure(with viewModel: CharacterCellViewModel) {
        profileImage.setCharacterImage(with: viewModel.profileImageUrl)
        profileImage.rounded()
        name.text = viewModel.name
        characterId = viewModel.id
    }
}
