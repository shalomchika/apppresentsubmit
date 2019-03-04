//
//  GiftViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 10/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import Firebase

class GiftViewController: UIViewController , UITableViewDelegate, UITableViewDataSource,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  
    @IBOutlet weak var shoptableview: UITableView!
    @IBOutlet weak var placetableview: UITableView!
    @IBOutlet weak var recentdetaillbl: UIButton!
    

    @IBOutlet weak var recentimageview: UIImageView!
    
    @IBOutlet weak var addrecentbtn: UIButton!
    @IBAction func showdetail(_ sender: Any) {
        let popoverVC  = UIStoryboard(name: "gifting", bundle:nil).instantiateViewController(withIdentifier: "sbPopupID") as! GiftPopUpViewController
        self.addChild(popoverVC)
        popoverVC.view.frame = self.view.frame
        self.view.addSubview(popoverVC.view)
        popoverVC.didMove(toParent: self)
        
    }
    
    
    var imagePicker = UIImagePickerController()
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
        addrecentbtn.addTarget(self, action: #selector(handlePickImage), for: .touchUpInside)
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
        
       self.shoptableview.delegate  = self
      self.placetableview.delegate = self
        //self.tableview.datasource  = self
        
       // self.shoptableview.reloadData()
        //self.placetableview.reloadData()
        
        

        // Do any additional setup after loading the view.
    }
    
    
    @objc func handlePickImage(picker: UIImagePickerController) {
       // let imagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        let actionsheet = UIAlertController(title: "Photo Source", message: "Choose A Source", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePicker.sourceType = .camera
                
                self.present(self.imagePicker, animated: true, completion: nil)
            }else
            {
                print("Camera is Not Available")
            }
            
            
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction)in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionsheet,animated: true, completion: nil)

        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    override func  viewWillAppear(_ animated: Bool) {
        
        //self.shoptableview.reloadData()
        //self.placetableview.reloadData()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            
        }
        recentimageview.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
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
            var dataname = shopdatasource[indexPath.row].name
            print(dataname)
            cell.shopnamelbl.text = dataname!
            return cell
        }
        
    }
    

}
