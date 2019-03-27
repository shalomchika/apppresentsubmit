//
//  GiftController.swift
//  apppresent
//
//  Created by Ky Nguyen on 3/13/19.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//
import UIKit
import GravitySliderFlowLayout
import Firebase
import FirebaseAuth
import PKHUD

class GiftController:UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static func create() -> GiftController {
        return UIStoryboard(name: "gifting", bundle: nil).instantiateViewController(withIdentifier: "GiftController") as! GiftController
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    var contributionlink = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentButton.addTarget(self, action: #selector(URLButtonPressed), for: .touchUpInside)
        //setupView()
        moreButton.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        collectionView.isPagingEnabled = true
        let gravitySliderLayout = UICollectionViewFlowLayout()
        gravitySliderLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = gravitySliderLayout
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLink()
        fetchData()
     }
    
    var datasource = [GiftData]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    func fetchLink() {
        let poolDB = DatabaseNode.getDb(.pools).child("owner")
        
        
        poolDB
            .observeSingleEvent(of: .value) { [weak self] (snapshot) in
                if let rawLink = snapshot.value as? String { return }
                self?.contributionlink = "\(link)"
                
                // https://stackoverflow.com/questions/44460165/reading-a-single-value-from-firebase-using-swift
                
                
        }
    }
    
    
    @objc func URLButtonPressed(_ sender: Any)  {
        
        
        
        
        guard let url = URL(string: "https://paypal.me/pools/c/8d7DqcbHSg") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    func fetchData() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        if datasource.isEmpty {
            HUD.show(.progress, onView: view)
        }
        
        Database.database().reference()
            .child("gifts")
            .queryOrdered(byChild: "owner")
            .queryEqual(toValue: userId)
            .observeSingleEvent(of: .value) { (snapshot) in
                guard let rawData = snapshot.value as? [String: AnyObject] else { return }
                let allValues = Array(rawData.values)
                var data = allValues.map({ return GiftData(rawData: $0) })
                data.sort(by: { $0.created > $1.created })
                
                self.datasource = data
                HUD.hide(animated: true)
        }
    }
    
    
    @objc func showMenu() {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        controller.addAction(UIAlertAction(title: "Add Online Gift Item" , style: .default, handler: { [weak self] _ in
            let controller  = AddGiftItemViewController.create()
            
            controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            //controller.navigationController?.present(controller, animated: true, completion: nil)
            
            
            self?.present(controller, animated: true, completion: nil)
            
        }))
        
        controller.addAction(UIAlertAction(title: "Edit Contribution Link", style: .default, handler: { [weak self] _ in
            
            let controller = ContributionViewController.create()
            
            
            
            
            controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            //controller.navigationController?.present(controller, animated: true, completion: nil)
            
            
            self?.present(controller, animated: true, completion: nil)
            
            
            
        }))
        /*
         controller.addAction(UIAlertAction(title: "Add Reminder", style: .default, handler: { [weak self] _ in
         let reminderController = ReminderViewController.create()
         reminderController.userProfile = self?.currentuserdata
         reminderController.hidesBottomBarWhenPushed = true
         self?.navigationController?.pushViewController(reminderController, animated: true)
         // for adding reminder on another user's account, set the user profile data with data of current profile
         
         
         
         }))
         */
        
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GiftSpecificCollectionViewCell
        cell.setData(datasource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

