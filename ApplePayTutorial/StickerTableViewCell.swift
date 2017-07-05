//
//  StickerTableViewCell.swift
//  ApplePayTutorial
//
//  Created by Chase McElroy on 7/5/17.
//  Copyright © 2017 Chase McElroy. All rights reserved.
//

import UIKit

class StickerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var imageInCell: UIImageView!

    func createStickerCell(sticker: Sticker) {
        nameLabel.text = sticker.name
        priceLabel.text = sticker.price
        imageInCell.image = sticker.image   
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
