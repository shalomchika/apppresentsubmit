//
//  ProfilePageViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 01/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SDWebImage
import Kingfisher
import PKHUD

class ProfilePageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITabBarControllerDelegate {
    var currentuserdata: UserData?
    static func create() -> ProfilePageViewController {
        return create(fromStoryboard: "profile")
    }
    
    
    var header: ProfileHeader?
    
    var activityindicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var datasource = [PostData]() //data structure defined
    //var ref = Database.database().reference()
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    @IBAction func editProfile(_ sender: Any) {
        let controller = EditProfileViewController.create()
        controller.profilePage = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let button = 
        
        //view.addSubviews(views: button)
        //button.center(toView: view)
       // button.topRight(toView: view, top: 35.0, right: -10.0)
        //button.topLeft(toView: view, top: 0.8, left: 0.6, isActive: true)
      //  button.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        getData()
        setupView()
    }
    
    @objc func showMenu() {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if isMyProfile {
            controller.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [weak self] _ in
                let editController = EditProfileViewController.create()
                editController.myProfile = self?.currentuserdata
                editController.hidesBottomBarWhenPushed = true
               self?.navigationController?.pushViewController(editController, animated: true)
            }))
            
            controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            // add 2 options:
            // - edit profile ( include edit size) 
            //
        } else {
            // add 2 options:
            // - show size
            // - add reminder
            controller.addAction(UIAlertAction(title: "Show Size", style: .default, handler: { [weak self] _ in
                let sizepopup = self?.showReferralPopup()
                
                
                
            }))
            
            controller.addAction(UIAlertAction(title: "View Favourite Gifts", style: .default, handler: { [weak self] _ in
                let sizepopup = self?.showReferralPopup()
                
                
                
            }))
            
            controller.addAction(UIAlertAction(title: "Add Reminder", style: .default, handler: { [weak self] _ in
                let reminderController = ReminderViewController.create()
                reminderController.userProfile = self?.currentuserdata
                reminderController.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(reminderController, animated: true)
                // for adding reminder on another user's account, set the user profile data with data of current profile
                
                
                
            }))
            
            controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
        
        present(controller, animated: true)
    }
    
    
    @objc func showReferralPopup() {
        ReferralPopup().show(in: view)
    }
    
    func getData() {
        let isFriendProfile = currentuserdata != nil
        if isFriendProfile {
            header?.setData(currentuserdata!)
            downloadPost(ofUser: currentuserdata!)
        } else {
            getMyProfile()
        }
    }
    
    func getMyProfile() {
        guard let myId = Setting.myId else { return }
        Database.database().reference()
            .child("users")
            .child(myId)
            .observeSingleEvent(of: .value) { [weak self] (snapshot) in
                guard let rawData = snapshot.value else { return }
                let myProfile = UserData(rawData: rawData)
                self?.currentuserdata = myProfile
                self?.header?.setData(myProfile)
                self?.downloadPost(ofUser: myProfile)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        header?.data = currentuserdata
    }
    
    func startloading () {
        
        self.view.addSubview(activityindicator)
        activityindicator.center = self.view.center
        activityindicator.hidesWhenStopped = true
        activityindicator.style = UIActivityIndicatorView.Style.gray
        activityindicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stoploading() {
        activityindicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func collectionView(_ collection: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        header?.datasourcecount = datasource.count
        return datasource.count
    }
    
    
    func downloadPost(ofUser user: UserData) {
        guard let userId = user.userId else { return }
       
        /*if imageview.image == nil {
            HUD.show(.progress, onView: imageview)
        }
        else {
            HUD.hide(animated: true)
        }*/
        
        if datasource.isEmpty {
            HUD.show(.progress, onView: view)
        }
        Database.database().reference(withPath: "posts")
            .queryOrdered(byChild: "userID").queryEqual(toValue: userId) // 2
            .observe(.value, with: { [weak self] (snapshot: DataSnapshot) in
                let newuserposts = snapshot.children.map({ return PostData(snapshot: $0 as! DataSnapshot)  })
                self?.datasource = newuserposts.sorted(by: { return $0.timestamp > $1.timestamp })
                self?.header?.setPostCount(newuserposts.count)
                //why herere please explain again?
                //it runs in deifferent thread -> you dont know when it finishs downloading
                // if you set in main thread at the same time with profile data -> youget 0
                // i f you add name, you also add avatar
                
                
                //HUD.show(.progress, onView: view)
                self?.collectionview.reloadData()
                HUD.hide(animated: true)
            })
    }
    //
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = PostDetail.create()
        controller.data = datasource[indexPath.row]
        controller.hidesBottomBarWhenPushed = true
        present(controller, animated: true)
    }
    
    func collectionView(_ collection: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        //reference cell
        //find right image in array
        
        let image = datasource[indexPath.row]
        
        //what is the type of cell
        //loop through every child node and grab - pathToImage
        print("is the url here too?")
        print(image.url)
        cell.imageview.downloadImage(from: image.url, placeholder: UIImage(named: ""))
        //cell.imageview.sd_setImage(with: URL(string: image.url), placeholderImage: nil)
        //cell.feedimageview.sd_setImage(with: URL(string: image.url), placeholderImage: UIImage(named:"image1"))
        
        return cell
    }
    
    
}

extension ProfilePageViewController {
    func setupView() {
        collectionview.register(ProfileHeader.create(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProfileHeader")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        header = collectionview.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProfileHeader", for: indexPath) as! ProfileHeader
        header?.parentController = self
        if let data = currentuserdata {
            header?.setData(data)
        }
        
        // add target from parrent controller
        // pass the parrent controlerl into the profile header
        // why use the second one now? - less functions, more useful
        //
        return header!
        
        // I dont think this class uses the userdata structure in the beginning , I only used a structure for the other classes.
        // when it is the logged in users account do I just change the currentuserdata value?
    }
    
}

extension ProfilePageViewController {
    var isMyProfile: Bool {
        guard let currentId = currentuserdata?.userId, let myId = Auth.auth().currentUser?.uid else { return false }
        return currentId == myId
    }
}
