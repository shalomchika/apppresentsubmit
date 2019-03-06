//
//  CustomImageFlowLayout.swift
//  apppresent
//
//  Created by Macbook Pro on 04/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit

class CustomImageFlowLayout: UICollectionViewFlowLayout {
//set the collection view to three columns, smaller spacing
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    override var itemSize: CGSize{
        set{}
        
       
        get{
            //calculate size for each element
            let numberofcolumns :CGFloat = 3
            let itemWidth = (self.collectionView!.frame.width  - numberofcolumns - 1 ) / numberofcolumns
            return CGSize (width: itemWidth, height: itemWidth)
        }
    }
    func setupLayout(){
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
}
