//
//  SearchTableViewCell.swift
//  apppresent
//
//  Created by Macbook Pro on 02/02/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var userprofileimage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
