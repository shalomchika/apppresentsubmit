//
//  GiftSpecificCollectionViewCell.swift
//  apppresent
//
//  Created by Macbook Pro on 19/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//
// the more button should it be in navigation bar , looks a little weird. the description text is quite close to the bottom a little too much?
import UIKit

class GiftSpecificCollectionViewCell: UICollectionViewCell {
    private var data: GiftData?
    func setData(_ data: GiftData) {
        self.data = data
        giftImageView.downloadImage(from: data.image, placeholder: UIImage(named: "gift_placeholder"))
        giftImageView.clipsToBounds = true
        giftLabel.text = data.description
        if let url = data.url, let description = data.description {
            giftLabel.text = "\(description)"
        }
    }
    
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var giftLabel: UILabel!
    @IBOutlet weak var viewDetailButton: UIButton!
    
    @IBAction func viewDetailAction(_ sender: Any) {
        
        guard let urlString = data?.url,
            let url = URL(string: urlString) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
}
