//
//  PlaceGiftCell.swift
//  apppresent
//
//  Created by Macbook Pro on 03/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit

class PlaceGiftCell: UITableViewCell {

    @IBOutlet weak var placeimageview: UIImageView!
    @IBOutlet weak var placenamelbl: UILabel!
 
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
