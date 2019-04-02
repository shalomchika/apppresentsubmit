//
//  ProfileHeader.swift
//  apppresent
//
//  Created by Macbook Pro on 01/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import UIKit
//import CountdownLabel
import FirebaseAuth

//https:github.com/suzuki-0000/CountdownLabel/blob/master/README.md
class ProfileHeader: UICollectionReusableView {
    //set the root view controller for tab
    weak var  parentController: ProfilePageViewController?
    var data: UserData?
    var datasourcecount: Int = 0
    var birthday: String?
    var birthdate: Date?
    var age: Int = 0
    //set variables for profile user details view
    
    //set variable buttons for actions and navigation
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    // follow is true and false, instead of 1 or remove 1 ( the node), for future reference with a lot of users is it better to remove the node, than to set it at false for every person they have ever followed? C
    
    func setPostCount(_ count: Int) {
        postCountLabel.text = String(count)
    }
    
    // set the data using the user from firebase from user data structure
    func setData(_ data: UserData) {
        self.data = data
        nameLabel.text = data.fullname
        avatarImageView.downloadImage(from: data.profileimageurl, placeholder: UIImage(named: "user_placeholder"))
        avatarImageView.contentMode = .scaleAspectFill
        statusLabel.text = data.status
        // if birthday exists, convert to date
        if let birthday = data.birthday, birthday.isEmpty == false,
            let birthdate = birthday.toDate() {
            
            self.birthday = birthday
            self.birthdate = birthdate
            //convert birthday to an age
            let ageInterval = Date().timeIntervalSince(birthdate)
            age = Int(ageInterval / (60 * 60 * 24 * 365))
            ageLabel.text = String(age)
            countDownLabel.text = countDown(toBirthdate: birthdate)
        //
        } else {
            ageLabel.text = "25"
            countDownLabel.text = " 11          5"
        }
    
        
        if checkIsMyProfile(data) {
            backButton.isHidden = true
            followButton.setTitle("Create Post", for: .normal)
            followButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
        } else {
            backButton.isHidden = false
            followButton.addTarget(self, action: #selector(changeFollowStatus), for: .touchUpInside)
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
                    // when in runs into this: -> you didn't fllow thisguy or the value is incorrect
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
        self.didFollow = didFollow
    }
    
    var didFollow = false
    @objc func changeFollowStatus() {
        didFollow = !didFollow
        guard let myId = Setting.myId,
            let toFollowId = data?.userId else { return }
        if didFollow {
            DatabaseNode.getDb(.following).child(myId).child(toFollowId).setValue(didFollow)
        } else {
            DatabaseNode.getDb(.following).child("following").child(myId).child(toFollowId).removeValue()
        }
        
        updateFollowStatus(didFollow)
        
    }
    
    func setFollowButton(by didFollow: Bool) {
        if didFollow {
            followButton.setTitle("Following", for: .normal)
            followButton.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1), for: .normal)
            followButton.backgroundColor = .clear
            followButton.setBorder(1, color: UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1))
        } else {
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(UIColor.white, for: .normal)
            followButton.backgroundColor = .c_102_100_247
            followButton.setBorder(1, color: UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1))
        }
    }
//UIColor.c_102_100_247, for: .normal)
    
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
        followButton.backgroundColor =// UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
                 UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
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
    
    @objc func createPost() {
        
        
        let controller = UploadPostViewController.create()
        
        
        controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        parentController?.navigationController?.present(controller, animated: true, completion: nil)
        
        
        
       // let controller = UploadPostViewController.create()
        
        //parentController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func countDown(toBirthdate: Date) -> String {
        let today = Date()
        let thisDay = today.day
        let thisMonth = today.month
        let birthDay = toBirthdate.day
        let birthMonth = toBirthdate.month
        
        let months = [
            1: 31,
            2: 28,
            3: 31,
            4: 30,
            5: 31,
            6: 30,
            7: 31,
            8: 31,
            9: 30,
            10: 31,
            11: 30,
            12: 31
        ]
        
        var monthCount = 0
        var dayCount = 0
        
        let dayInMonth = months[thisMonth] ?? 31
        if thisMonth == birthMonth {
            if thisDay == birthDay {
                monthCount = 0
                dayCount = 0
            } else if thisDay > birthDay {
                monthCount = 11
                dayCount = dayInMonth - (thisDay - birthDay)
            } else if thisDay < birthDay {
                monthCount = 0
                dayCount = birthDay - thisDay
            }
        } else if thisMonth < birthMonth {
            if thisDay == birthDay {
                monthCount = birthMonth - thisMonth
                dayCount = 0
            } else if thisDay > birthDay {
                monthCount = birthMonth - thisMonth - 1
                dayCount = dayInMonth - (thisDay - birthDay)
            } else if thisDay < birthDay {
                monthCount = birthMonth - thisMonth
                dayCount = birthDay - thisDay
            }
        } else if thisMonth > birthMonth {
            if thisDay == birthDay {
                monthCount = thisMonth - birthMonth
                dayCount = 0
            } else if thisDay > birthDay {
                monthCount = 12 - (thisMonth - birthMonth)
                dayCount = dayInMonth - (thisDay - birthDay)
            } else if thisDay < birthDay {
                monthCount = 12 - (thisMonth - birthMonth)
                dayCount = birthDay - thisDay
            }
        }
        let monthString = monthCount > 0 ? "  \(monthCount)   " : ""
        let dayString = dayCount > 0 ? "    \(dayCount)" : ""
        //let monthString = monthCount > 0 ? "\(monthCount)m " : ""
        //let dayString = dayCount > 0 ? "\(dayCount)d" : ""
        let result = monthCount == 0 && dayCount == 0 ? "Today" : "\(monthString)\(dayString)"
        return result
        
    }
    
}

//https:stackoverflow.com/questions/40541699/converting-string-to-date-using-dd-mm-yyyy-get-nil-in-xcode-8-in-swift-3-0
extension String {
    func toDate() -> Date? {
        guard let timestamp = Double(self) else { return nil }
        return Date(timeIntervalSince1970: timestamp)
    }
    
    func changeDate(_ mydate:String) -> Date{
        guard let interval = Double(mydate) else { return Date() }
        return Date(timeIntervalSince1970: interval)
    }
}
