//
//  UIImageViewExtensions.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func rounded() {
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.height / 2
            self.layer.masksToBounds = true
        }
    }

    func setCharacterImage(with url: URL?, placehoder: UIImage? = .placeholderCharacter) {
        tintColor = .white
        setImage(with: url, placeholder: placehoder)
    }

    func setImage(with url: URL?, placeholder: UIImage?) {
        kf.setImage(with: url, placeholder: placeholder)
    }
}
