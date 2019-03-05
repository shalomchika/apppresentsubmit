//
//  GiftViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 10/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import Firebase

class GiftViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    var recentimgarray = [UIImage(named: "store"), UIImage(named: "store"), UIImage(named: "store"), UIImage(named: "store"), UIImage(named: "store"), UIImage(named: "store")]
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentimgarray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCollectionViewCell", for: indexPath)  as! RecentCollectionViewCell
        
        cell.recentimageview.image = recentimgarray[indexPath.row]
        return cell
    }
  
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let myId = Auth.auth().currentUser?.uid else { return }
        let shopDB = Database.database().reference().child("shops")
            .observe(.value) { (returnData) in
                guard let rawData = returnData.value as? [String: Any] else { return }
                self.shoparray = Array(rawData.values).map({ return Shop(rawData: $0) })
        }
        let placeDB = Database.database().reference().child("places").observe(.value) { (returnData) in
            guard let rawData = returnData.value as? [String: Any] else { return }
            self.placearray = Array(rawData.values).map({ return Place(rawData: $0) })
            print(self.placearray)
        }
        
        
        //self.tableview.datasource  = self
        
        // self.shoptableview.reloadData()
        //self.placetableview.reloadData()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func showdetail(_ sender: Any) {
        let popoverVC  = UIStoryboard(name: "gifting", bundle:nil).instantiateViewController(withIdentifier: "sbPopupID") as! GiftPopUpViewController
        self.addChild(popoverVC)
        popoverVC.view.frame = self.view.frame
        self.view.addSubview(popoverVC.view)
        popoverVC.didMove(toParent: self)
        
    }
    

    
    
    @IBAction func editrecent(_ sender: Any) {
        
        let controller = AddRecentViewController.create()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    

    
    
    static func create() -> GiftViewController {
        return UIStoryboard(name: "gifting", bundle: nil).instantiateViewController(withIdentifier: "GiftViewController") as! GiftViewController
    }
    
    class ShopArray {
        var shoparray = [Shop]()
        
    }
    // class to access arrays
    class PlaceArray {
        var placearray = [Place]()
    }
    
    //create array
    
    var shoparray = ShopArray().shoparray
    var placearray = PlaceArray().placearray
    var shopdatasource = [Shop] ()
    var placedatasource = [Place]()
    
  

   
     
        //self.tableview.datasource  = self
        
       // self.shoptableview.reloadData()
        //self.placetableview.reloadData()
        
        

        // Do any additional setup after loading the view.
    }
    
    
   
    
    
  
    
    
   
    


