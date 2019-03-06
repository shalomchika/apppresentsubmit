//
//  ProfileHeader.swift
//  apppresent
//
//  Created by Ky Nguyen on 3/5/19.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit

class ProfileHeader: UICollectionReusableView {

    var data: UserData?
    func setData(_ data: UserData) {
        self.data = data
        nameLabel.text = data.fullname
        avatarImageView.downloadImage(from: data.profileimageurl)
        statusLabel.text = data.status
        
        if checkIsMyProfile(data) {
            followButton.setTitle("Create Post", for: .normal)
            followButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
        } else {
            updateFollowStatus()
        }
    }
    
    
    func updateFollowStatus() {
        let followStatus = didFollow ? "Following" : "Follow"
        followButton.setTitle(followStatus, for: .normal)
        if didFollow {
            followButton.addTarget(self, action: #selector(unFollowThisGuy), for: .touchUpInside)
            followButton.removeTarget(self, action: #selector(followThisGuy), for: .touchUpInside)
            
            followButton.backgroundColor = .white
            followButton.setTitleColor(UIColor.c_102_100_247, for: .normal)
            followButton.setBorder(0.5, color: UIColor.c_102_100_247)
        } else {
            followButton.addTarget(self, action: #selector(followThisGuy), for: .touchUpInside)
            followButton.removeTarget(self, action: #selector(unFollowThisGuy), for: .touchUpInside)
            
            followButton.backgroundColor = .c_102_100_247
            followButton.setTitleColor(UIColor.white, for: .normal)
            followButton.setBorder(0.5, color: UIColor.c_102_100_247)
        }
    }
    
    var didFollow = false
    
    @objc func followThisGuy() {
        print("OK. Followed")
        didFollow = true

        // update fire base
        
        // update button color, title
        updateFollowStatus()
    }
    @objc func unFollowThisGuy() {
        print("OK. Not follow anymore ")
        didFollow = false
        // update fire base
        // update button color, title
        updateFollowStatus()
    }
    
    
    @objc func createPost() {
        print("Showing create post controller")
    }
    
    func checkIsMyProfile(_ profile: UserData) -> Bool {
        guard let currentId = profile.userId, let myId = Setting.myId else { return false }
        return currentId == myId
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var postCountLabel: UILabel!
    
    @IBOutlet weak var sizeinfoButton: UIButton!
    
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