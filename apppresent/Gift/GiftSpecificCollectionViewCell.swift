//
//  GiftSpecificCollectionViewCell.swift
//  apppresent
//
//  Created by Macbook Pro on 19/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit

class GiftSpecificCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var giftLabel: UILabel!
    @IBOutlet weak var viewDetailButton: UIButton!
    
    @IBAction func viewDetailAction(_ sender: Any) {
        guard let url = URL(string: "https://paypal.me/pools/c/8d7DqcbHSg") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
}
