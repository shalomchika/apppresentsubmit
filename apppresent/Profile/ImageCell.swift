//
//  CollectionViewCell.swift
//  apppresent
//
//  Created by Macbook Pro on 04/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
//for image view alone

class ImageCell: UICollectionViewCell {
   
    @IBOutlet weak var imageview: UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageview.image = nil
    
    }
    
}
