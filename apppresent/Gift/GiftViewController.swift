//
//  GiftViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 10/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import Firebase

class GiftViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
  
    @IBOutlet weak var shoptableview: UITableView!
    @IBOutlet weak var placetableview: UITableView!
    
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
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let myId = Auth.auth().currentUser?.uid else { return }
        /*
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
    */
        
       self.shoptableview.delegate  = self
      self.placetableview.delegate = self
        //self.tableview.datasource  = self
        
       // self.shoptableview.reloadData()
        //self.placetableview.reloadData()
        
        

        // Do any additional setup after loading the view.
    }
    
    
    override func  viewWillAppear(_ animated: Bool) {
        
        //self.shoptableview.reloadData()
        //self.placetableview.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    if(tableView == placetableview) {
        
      return placedatasource.count
    }
        
    else {
     
            return shopdatasource.count
        
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == placetableview) {
            var cell = tableView.dequeueReusableCell(withIdentifier: "PlaceGiftCell") as! PlaceGiftCell
            
            // fetch an example optional string
            //let optionalString = datasource[indexPath.row].fullname?.description
            
            // now unwrap it
            var dataname = placedatasource[indexPath.row].name
            cell.placenamelbl.text = dataname!
            return cell
        }
        else {
       
            var cell = tableView.dequeueReusableCell(withIdentifier: "ShopGiftCell") as! ShopGiftCell
            
            // fetch an example optional string
            //let optionalString = datasource[indexPath.row].fullname?.description
            
            // now unwrap it
            //var dataname = shopdatasource[indexPath.row].name
            //print(dataname)
            //cell.shopnamelbl.text = dataname!
            return cell
        }
        
    }
    

}
