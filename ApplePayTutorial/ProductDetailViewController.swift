//
//  ProductDetailViewController.swift
//  ApplePayTutorial
//
//  Created by Chase McElroy on 7/5/17.
//  Copyright © 2017 Chase McElroy. All rights reserved.
//

import UIKit
import PassKit

class ProductDetailViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var applePayView: UIView!
    
    var email: String?
    
    var sticker = Sticker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = sticker.name
        imageView.image = sticker.image
        priceLabel.text = "$\(sticker.price!)"
        
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
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
        self.email = payment.shippingContact?.emailAddress
        completion(.success)
        
        // You can grab email and stuff from here
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true) {
            if let email = self.email {
                self.performSegue(withIdentifier: "thankYouSegue", sender: email)
                self.email = nil
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
            
        }
    }
    

    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didSelect shippingMethod: PKShippingMethod, completion: @escaping (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) {
        completion(.success, allTheSummaryItems(shippingMethod: shippingMethod))
    }
    
    
    
    func allTheSummaryItems(shippingMethod: PKShippingMethod) -> [PKPaymentSummaryItem] {
        let stickerSummary = PKPaymentSummaryItem(label: sticker.name, amount: NSDecimalNumber(string: sticker.price))

        let stickerDiscount = PKPaymentSummaryItem(label: "Cat Discount", amount: NSDecimalNumber(value: -2.00))
        let shipping = PKPaymentSummaryItem(label: shippingMethod.label, amount: shippingMethod.amount)
        let total = PKPaymentSummaryItem(label: "Sticker Cove", amount: stickerSummary.amount.adding(stickerDiscount.amount).adding(shippingMethod.amount).adding(shipping.amount))
        return [stickerSummary, stickerDiscount, shipping, total]
    }
    
    func applePayTapped() {
        let request = PKPaymentRequest()
        request.supportedNetworks = [.amex, .visa, .masterCard]
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.merchantIdentifier = "merchant.bio.chase.applepaytutorial"
        request.merchantCapabilities = .capability3DS
        
        request.requiredShippingAddressFields = .email
        
        let freeShipping = PKShippingMethod(label: "Free Shipping", amount: NSDecimalNumber(value: 0.0))
        freeShipping.identifier = "freeShipping"
        freeShipping.detail = "Usually ships in 5-12 days"
        
        let expressShipping = PKShippingMethod(label: "Express Shipping", amount: NSDecimalNumber(value: 5.49))
        expressShipping.identifier = "expressShipping"
        expressShipping.detail = "Usually ships in 2-5 days"
        
        let overNightShipping = PKShippingMethod(label: "Over Night Shipping", amount: NSDecimalNumber(value: 16.49))
        overNightShipping.identifier = "overNightShipping"
        overNightShipping.detail = "Usually ships in 1 day"
        
        
        request.shippingMethods = [freeShipping, expressShipping, overNightShipping]

        
        request.paymentSummaryItems = allTheSummaryItems(shippingMethod: freeShipping)
        
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        
        applePayController.delegate = self
        
        // in the completion handler you can change the background
        present(applePayController, animated: true, completion: nil)
    }

    @IBAction func creditCardBtnPressed(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? ThankYouViewController {
            if sender != nil {
                if let email = sender as? String {
                    detailVC.email = email
                }
            }
        }
    }

}
