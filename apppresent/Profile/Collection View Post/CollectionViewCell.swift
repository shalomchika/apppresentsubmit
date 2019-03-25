//
//  CollectionViewCell.swift
//  apppresent
//
//  Created by Macbook Pro on 04/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import PKHUD

//for image view alone

class CollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var imageview: UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageview.image = nil
         
        
        
        
    }
    
}
