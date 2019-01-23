//
//  PostTableViewCell.swift
//  
//
//  Created by Macbook Pro on 21/01/2019.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    //
    //  PostTableViewCell.swift
    //  apppresent
    //
    //  Created by Macbook Pro on 21/01/2019.
    //  Copyright © 2019 Macbook Pro. All rights reserved.
    //
        
        @IBOutlet weak var imageview: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageview.image = nil
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
