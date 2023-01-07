//
//  ProductTableViewCell.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import UIKit
import SDWebImage
class ProductTableViewCell: UITableViewCell, Reusable{
    @IBOutlet var containerView: UIView!
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(withCharacter character: CharacterModel) {
        nameLabel.text = character.name
        statusLabel.text = character.status?.rawValue
        locationLabel.text = character.location?.name
        guard let urlString = character.image, let imageURL = URL(string: urlString) else { return }
        characterImageView.sd_setImage(with: imageURL)
    }
    
}
