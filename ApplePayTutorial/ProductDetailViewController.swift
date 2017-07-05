//
//  ProductDetailViewController.swift
//  ApplePayTutorial
//
//  Created by Chase McElroy on 7/5/17.
//  Copyright © 2017 Chase McElroy. All rights reserved.
//

import UIKit
import PassKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var applePayView: UIView!
    
    var sticker = Sticker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = sticker.name
        imageView.image = sticker.image
        priceLabel.text = sticker.price
        
        var button : PKPaymentButton
        if PKPaymentAuthorizationViewController.canMakePayments() {
            button = PKPaymentButton(type: .buy, style: .black)
        } else {
            button = PKPaymentButton(type: .setUp, style: .black)
        }
        
        self.view.layoutIfNeeded()
        
        
        button.addTarget(self, action: #selector(ProductDetailViewController.applePayTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: self.applePayView.frame.size.width, height: self.applePayView.frame.size.height)
        self.applePayView.addSubview(button)
    }
    
    func applePayTapped() {
        print("pay time")
    }

    @IBAction func creditCardBtnPressed(_ sender: Any) {
    }

}
