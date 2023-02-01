//
//  CharacterDetailView.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import UIKit
import Alamofire

class CharacterDetailView: UIViewController, CreatableView {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var descriptionTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var sectionsStack: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: CharacterDetailPresenterContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
    }
}

extension CharacterDetailView: CharacterDetailViewContract {
    internal func configure(with character: Character) {
        DispatchQueue.main.async {
            self.title = character.name
            if character.description == "" {
                self.descriptionTopConstraint.constant = 0.0
            }
            self.descriptionLabel.text = character.description
            self.profileImage.setCharacterImage(with: URL(string: character.thumbnail.path + "." + character.thumbnail.thumbnailExtension))
            
            if character.comics.available > 0 {
                let comics = character.comics.items
                self.createSection(SectionType.comics, sectionItems: comics)
            }
            
            if character.series.available > 0 {
                let series = character.series.items
                self.createSection(SectionType.series, sectionItems: series)
            }
            
            if character.stories.available > 0 {
                let stories = character.stories.items
                self.createSection(SectionType.stories, sectionItems: stories)
            }
            
            if character.events.available > 0 {
                let events = character.events.items
                self.createSection(SectionType.events, sectionItems: events)
            }
            
            if character.urls.count > 0 {
                let urls = character.urls
                self.createSection(SectionType.urls, urls: urls)
            }
        }
    }
    
    internal func startActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    internal func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    func errorAlertAction() -> UIAlertAction {
        return UIAlertAction(title: "OK", style: .cancel) { action in
            self.navigationController?.popViewController(animated: true)
        }
    }
}

private extension CharacterDetailView {
    func createSection(_ sectionType: SectionType, sectionItems: [SectionItem] = [], urls: [Url] = []) {
        let view = UIView()
        let titleLabel = UILabel()
        let stackView = UIStackView()
        stackView.axis = .vertical
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20.0)
        stackView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        configure(label: titleLabel, with: sectionType)
        configure(stackView: stackView, withType: sectionType, items: sectionItems, urls: urls)
        
        self.sectionsStack.addArrangedSubview(view)
    }
    
    func configure(label: UILabel, with sectionType: SectionType) {
        label.setHeight(height: 30)
        label.text = sectionType.rawValue
        label.font = UIFont.boldSystemFont(ofSize: 21.0)
    }
    
    func configure(stackView: UIStackView, withType sectionType: SectionType, items: [SectionItem], urls: [Url]) {
        sectionType == .urls ?
        urls.forEach { stackView.addArrangedSubview(urlTextView(for: $0)) } :
        items.forEach { stackView.addArrangedSubview(sectionLabel(for: $0)) }
    }
    
    func urlTextView(for url: Url) -> UITextView {
        let textView = UITextView()
        let attributedLinkString = NSMutableAttributedString(string: url.type.title, attributes:[NSAttributedString.Key.link: URL(string: url.url)!])
        textView.attributedText = attributedLinkString
        textView.setHeight(height: 30)
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 17.0)
        return textView
    }
    
    func sectionLabel(for item: SectionItem) -> UILabel {
        let label = UILabel()
        label.text = item.name
        label.setHeight(height: 30)
        return label
    }
}
