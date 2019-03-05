//
//  ProfileHeader.swift
//  apppresent
//
//  Created by Ky Nguyen on 3/5/19.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit

class ProfileHeader: UICollectionReusableView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var postCountLabel: UILabel!
    
    static func create() -> UINib {
        return UINib(nibName: "ProfileHeader", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        avatarImageView.setCorner(radius: 48)
        followButton.setCorner(radius: 5)
        followButton.backgroundColor = UIColor.c_102_100_247
        followButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
}
