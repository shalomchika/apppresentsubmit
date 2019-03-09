//
//  ProfileHeader.swift
//  apppresent
//
//  Created by Ky Nguyen on 3/5/19.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import Firebase

class ProfileHeader: UICollectionReusableView {

    var data: UserData?
    var datasourcecount: Int = 0
    
    

    
    func setData(_ data: UserData) {
        self.data = data
        nameLabel.text = data.fullname
        avatarImageView.downloadImage(from: data.profileimageurl)
        statusLabel.text = data.status
        var profilecount = datasourcecount
        //let sections = profilecollection?.dataSource
        postCountLabel.text = "\(profilecount)"
        var birthday: String?
        birthday = data.birthday
        var birthdate = birthday?.changeDate(birthday!)
        var ageInterval = Date().timeIntervalSince(birthdate ?? Date())
        var age = Int(ageInterval / (60 * 60 * 24 * 365))
        var agestring = String(age)
        if age == 0 {
            agestring = "Eternal"
        }
        ageLabel.text = agestring ?? ""
        //countDownLabel.text =
        
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
        let myId = Setting.myId
        let toFollowId = data?.userId
        let tofollowValue = 1
        
        let ref = Database.database().reference().child("following").child(myId ?? "")
       
       ref.updateChildValues([toFollowId: tofollowValue])
        // update fire bas
        
        // update button color, title
        updateFollowStatus()
    }
    @objc func unFollowThisGuy() {
        print("OK. Not follow anymore ")
        
        let myId = Setting.myId
        let toFollowId = data?.userId
        
        let ref = Database.database().reference().child("following").child(myId ?? "").child(toFollowId ?? "")
        
        ref.removeValue()
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

//https:stackoverflow.com/questions/40541699/converting-string-to-date-using-dd-mm-yyyy-get-nil-in-xcode-8-in-swift-3-0
extension String {
    func changeDate(_ mydate:String) -> Date{
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let convertedDate = dateFormatter.date(from: mydate)
        return convertedDate!
    }
}
