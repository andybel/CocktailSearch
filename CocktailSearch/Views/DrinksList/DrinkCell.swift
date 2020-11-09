//
//  DrinkCell.swift
//  CocktailSearch
//
//  Created by Andy Bell on 04.11.20.
//

import UIKit

final class DrinkCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgLoadView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgView.layer.cornerRadius = 4.0
        imgView.clipsToBounds = true
        titleLabel.accessibilityIdentifier = "drink_cell_title_label"
        authorLabel.accessibilityIdentifier = "drink_cell_author_label"
    }
    
    func configure(with drink: Drink) {
        
        titleLabel.text = drink.name
        authorLabel.text = drink.category
        descriptionLabel.text = drink.instructions ?? ""

        imgView.image = nil
        imgLoadView.isHidden = false
        if let urlStr = drink.thumbnailUrl,
           let url = URL(string: urlStr) {
            imgView.loadImage(at: url) { [weak self] in
                self?.imgLoadView.isHidden = true
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
        imgLoadView.isHidden = false
    }

}
