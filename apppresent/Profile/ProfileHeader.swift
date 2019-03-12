//
//  ProfileHeader.swift
//  apppresent
//
//  Created by Ky Nguyen on 3/5/19.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import UIKit
import CountdownLabel
import FirebaseAuth

//https:github.com/suzuki-0000/CountdownLabel/blob/master/README.md
class ProfileHeader: UICollectionReusableView {
    weak var  parentController: ProfilePageViewController?
    var data: UserData?
    var datasourcecount: Int = 0
    var birthday: String?
    var birthdate: Date?
    var age: Int = 0
    // back arrow to iamge
    
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    // I should always take the birthday when user . but I allow their age
    
    func setPostCount(_ count: Int) {
        postCountLabel.text = String(count)
    }
    
    func setData(_ data: UserData) {
        self.data = data
        nameLabel.text = data.fullname
        avatarImageView.downloadImage(from: data.profileimageurl)
        statusLabel.text = data.status
    
        if let birthday = data.birthday, birthday.isEmpty == false,
            let birthdate = birthday.toDate() {
            self.birthday = birthday
            self.birthdate = birthdate
            let ageInterval = Date().timeIntervalSince(birthdate)
            age = Int(ageInterval / (60 * 60 * 24 * 365))
            ageLabel.text = String(age)
        } else {
            ageLabel.text = "N/A"
        }
    
        
    
        
        // I need to give them the option to not put their birthday/age
        // there is no birthday saved in my database for some people because I made it up
        // Should I ask them for their birthday and age still but give them the option to hide it?
        // From a few surveys some people feel uncomfortable showing their age, but I guess they would still use it for people to know how many days until their birthday, so its their age not their birthday they want to hide.
        
       // countDownLabel.text =
        
    
        
        
        if checkIsMyProfile(data) {
            backButton.isHidden = true
            followButton.setTitle("Create Post", for: .normal)
            followButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
        } else {
            backButton.isHidden = false
            
            checkFollowStatus()
        }
    }
    
    func checkFollowStatus() {
        guard let friendId = data?.userId, let myId = Auth.auth().currentUser?.uid else { return }
        Database.database().reference()
            .child("following")
            .child(myId)
            .child(friendId)
            .observeSingleEvent(of: .value) {[weak self] (snapshot) in
                guard let value = snapshot.value as? Bool else {
                    // when in runs into this: -> you didn't fllow thisguy or the value is incorrect (changed by somereason)
                    // -< consider not folow yet
                    self?.updateFollowStatus(false)
                    return
                }
                // checking the follow status in firebase? to decide what to pass to updateFollow status
                self?.updateFollowStatus(value)
        }
    }
    
   // https:medium.com/@kamalupasena/countdown-timer-swift-3-8265686e8191
    func setTimeLeft() {
        
        let timeNow = Date()
        let timeEnd = birthdate
        if timeEnd?.compare(timeNow) == ComparisonResult.orderedDescending {
            
            let interval = timeEnd?.timeIntervalSince(timeNow)
            
            let days =  (interval! / (60*60*24)).rounded(.down)
            
            let daysRemainder = interval?.truncatingRemainder(dividingBy: 60*60*24)
            
            let hours = (daysRemainder! / (60 * 60)).rounded(.down)
            
            let hoursRemainder = daysRemainder?.truncatingRemainder(dividingBy: 60 * 60).rounded(.down)
            
            let minutes  = (hoursRemainder! / 60).rounded(.down)
            
            let minutesRemainder = hoursRemainder?.truncatingRemainder(dividingBy: 60).rounded(.down)
            
            let scondes = minutesRemainder?.truncatingRemainder(dividingBy: 60).rounded(.down)
            
        }
        
    }

    
    func updateFollowStatus(_ didFollow: Bool) {
        setFollowButton(by: didFollow)
        if didFollow {
            followButton.addTarget(self, action: #selector(unFollowThisGuy), for: .touchUpInside)
            followButton.removeTarget(self, action: #selector(followThisGuy), for: .touchUpInside)
        } else {
            followButton.addTarget(self, action: #selector(followThisGuy), for: .touchUpInside)
            followButton.removeTarget(self, action: #selector(unFollowThisGuy), for: .touchUpInside)
        }
    }
    
    var didFollow = false
    
    @objc func followThisGuy() {
        print("OK. Followed")
        didFollow = true
        let myId = Setting.myId
        let toFollowId = data?.userId
        let tofollowValue = 1
        
        //let ref = Database.database().reference().child("following").child(myId ?? "")
       
       //ref.updateChildValues([toFollowId: tofollowValue])
        // update fire bas
        
        // update button color, title
        updateFollowStatus(true)
    }
    
    func setFollowButton(by didFollow: Bool) {
        if didFollow {
            followButton.setTitle("Following", for: .normal)
            followButton.setTitleColor(UIColor.c_102_100_247, for: .normal)
            followButton.backgroundColor = .clear
            followButton.setBorder(1, color: UIColor.c_102_100_247)
        } else {
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(UIColor.white, for: .normal)
            followButton.backgroundColor = .c_102_100_247
            followButton.setBorder(1, color: UIColor.c_102_100_247)
        }
    }
    
    @objc func unFollowThisGuy() {
        print("OK. Not follow anymore ")
        
        let myId = Setting.myId
        let toFollowId = data?.userId
        
        //let ref = Database.database().reference().child("following").child(myId ?? "").child(toFollowId ?? "")
        
        //ref.removeValue()
        didFollow = false
        // update fire base
        updateFollowStatus(false)
    }
    
    
    @objc func createPost() {
        //parentController?.navigationController
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
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    @IBAction func showInfoChoice(_ sender: Any) {
        
        infoButton.addTarget(parentController, action: #selector(parentController?.showMenu), for: .touchUpInside)
        
    }
    
    
    @objc func showProfileChoices() {
       
       // infoButton.addTarget(self, action: #selector(parentController?.showMenu), for: .touchUpInside)
    }
    
    @objc func goBack() {
        parentController?.navigationController?.popViewController(animated: true)
    }
}

//https:stackoverflow.com/questions/40541699/converting-string-to-date-using-dd-mm-yyyy-get-nil-in-xcode-8-in-swift-3-0
extension String {
    func toDate() -> Date? {
        guard let timestamp = Double(self) else { return nil }
        return Date(timeIntervalSince1970: timestamp)
    }
}
