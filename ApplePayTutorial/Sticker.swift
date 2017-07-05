//
//  Sticker.swift
//  ApplePayTutorial
//
//  Created by Chase McElroy on 7/5/17.
//  Copyright © 2017 Chase McElroy. All rights reserved.
//

import UIKit

class Sticker {
    var name: String!
    var price: String!
    var image: UIImage!
    
    static func createStickers() -> [Sticker] {
        let cat = Sticker()
        cat.name = "Cat Made Out of Pizza"
        cat.price = "4.99"
        cat.image = UIImage(named: "catPizza") ?? UIImage()
        
        let kitten = Sticker()
        kitten.name = "Kitten Holding Pizza"
        kitten.price = "14.99"
        kitten.image = UIImage(named: "kittenPizza") ?? UIImage()
        
        let cool = Sticker()
        cool.name = "Coolest of the Cats"
        cool.price = "2.99"
        cool.image = UIImage(named: "coolCat") ?? UIImage()
        
        return [cat, kitten, cool]
    }
}
