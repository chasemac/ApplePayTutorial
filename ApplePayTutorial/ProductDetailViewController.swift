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
        let request = PKPaymentRequest()
        request.supportedNetworks = [.amex, .visa, .masterCard]
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.merchantIdentifier = "merchant.bio.chase.applepaytutorial"
        request.merchantCapabilities = .capability3DS
        
        let stickerSummary = PKPaymentSummaryItem(label: "Sticker of Cat", amount: NSDecimalNumber(value: 2.67))
        let stickerKitten = PKPaymentSummaryItem(label: "Sticker of Kitten", amount: NSDecimalNumber(value: 2.67))
        let stickerDiscount = PKPaymentSummaryItem(label: "Cat Discount", amount: NSDecimalNumber(value: -2.00))
        let total = PKPaymentSummaryItem(label: "Sticker Cove", amount: stickerSummary.amount.adding(stickerKitten.amount).adding(stickerDiscount.amount))
        
        request.paymentSummaryItems = [stickerSummary, stickerKitten, stickerDiscount, total]
        
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        // in the completion handler you can change the background
        present(applePayController, animated: true, completion: nil)
    }

    @IBAction func creditCardBtnPressed(_ sender: Any) {
    }

}
