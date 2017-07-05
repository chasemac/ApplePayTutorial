//
//  ViewController.swift
//  ApplePayTutorial
//
//  Created by Chase McElroy on 7/5/17.
//  Copyright © 2017 Chase McElroy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var stickers : [Sticker] = Sticker.createStickers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(stickers.count)
        return stickers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "stickerCell") as! StickerTableViewCell? {
            let sticker = self.stickers[indexPath.row]
//            cell.createStickerCell(sticker: sticker)
            cell.nameLabel.text = sticker.name
            cell.priceLabel.text = sticker.price
            cell.imageInCell.image = sticker.image
            
            return cell
        }
        return UITableViewCell()

    }



}

