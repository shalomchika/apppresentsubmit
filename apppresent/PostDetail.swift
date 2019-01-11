//
//  PostDetail.swift
//  apppresent
//
//  Created by Macbook Pro on 09/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit

class PostDetail: UIViewController {

    let newImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var captionlbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(newImageView)
        
    

    }
    
}



