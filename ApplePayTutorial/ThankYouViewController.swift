//
//  ThankYouViewController.swift
//  ApplePayTutorial
//
//  Created by Chase McElroy on 7/5/17.
//  Copyright © 2017 Chase McElroy. All rights reserved.
//

import UIKit

class ThankYouViewController: UIViewController {
    
    @IBOutlet weak var thankYouLabel: UILabel!
    
    @IBOutlet weak var conView: UIView!
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.thankYouLabel.text = "Your order has been completed and a receipt has been sent to \(self.email). Thank you for your purchase! :)"
        
        

//
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let confettiView = SAConfettiView(frame: self.conView.bounds)
//        self.conView.addSubview(confettiView)
//        confettiView.startConfetti()
//    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
