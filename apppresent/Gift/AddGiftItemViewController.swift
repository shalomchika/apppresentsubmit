//
//  AddGiftItemViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 23/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import PKHUD
import Firebase

class AddGiftItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    static func create() -> AddGiftItemViewController {
        return UIStoryboard(name: "gifting", bundle: nil).instantiateViewController(withIdentifier: "AddGiftItemViewController") as! AddGiftItemViewController
    }
    
    @IBOutlet weak var addGiftButton: UIButton!
    @IBOutlet weak var descriptionTextfield: UITextView!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var giftLinkTextfield: UITextField!
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var giftItem = [GiftData]()
   var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        addGiftButton.addTarget(self, action: #selector(handlePickImage), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(addItem), for: .touchUpInside)
        dismissButton.addTarget(self, action: #selector(dismissScreen), for: .touchUpInside)
        
        saveButton.setCorner(radius: 7)
        saveButton.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        setupView()
    }
    //?
    @objc func dismissScreen() {
        dismiss(animated: true)
    }
    
    func setupView() {
        
        
        descriptionTextfield.backgroundColor = .white
        descriptionTextfield.setBorder(1, color: .white)
        descriptionTextfield.setCorner(radius: 7)
        
        //giftLinkTextfield.setBorder(1, color: .lightGray)
        //giftLinkTextfield.setCorner(radius: 7)
        giftLinkTextfield.addBottomBorder()
        // Left view and right view for textField
        
        saveButton.setCorner(radius: 7)
        giftImageView.image = UIImage(named: "camera")
        giftImageView.contentMode = .scaleAspectFit
    }
    
    
    @objc func handlePickImage(picker: UIImagePickerController) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    
    var selectedImage: UIImage?
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            
        }
        
        giftImageView.contentMode = .scaleAspectFit
        giftImageView.image = image
        selectedImage = image
        
        // Dismiss the picker.
        picker.dismiss(animated: true)
    }//can I make the pictures a fixed size or more similar size, an aspect ration or ?... not distorted
    
     // what is the link in initial?
    //Its nothing until you set it? maybe it should go to paypal the website ( root) , the
    // when I change link to google.com -> my link
    // the edit page when you change it , when you click on the button it should go to new link
    // this gift page is part of the action sheet for going to another user's profile.
    
    
    @objc func addItem() {
        let id = UUID().uuidString
        let description  = descriptionTextfield.text
        let link = giftLinkTextfield.text
        
        guard let selectedImage = selectedImage else { return }
        guard let userid = Auth.auth().currentUser?.uid else { return }
        HUD.show(.progress, onView: view)
        hideKeyboard()
        let giftDb = Database.database().reference().child("gifts").child(id)
        //var caption = captionlbl.text
        let item = ["id": id,
                    "owner": userid,
                    "description": description,
                    "created": Date().timeIntervalSince1970,
                    "link" : link]
                     as [String : Any?]
        giftDb.setValue(item)
        let storage = Storage.storage().reference(forURL: "gs://apppresent.appspot.com")
        if let data = selectedImage.jpegData(compressionQuality: 0.6) {
            let imageRef = storage.child("gifts").child(id)
            imageRef.putData(data, metadata: nil) { (metadata, err) in
                imageRef.downloadURL(completion: { (url, downloadErr) in
                    if let downloadUrl = url?.absoluteString {
                        giftDb.child("imageUrl").setValue(downloadUrl)
                        HUD.hide()
                        self.dismiss(animated: true)
                    }
                })
            }
        }
    }
    // sorry to be annoying but should I add a title to the gift or is it clear what it is ?\\
        //create a unique ID
        //save text in description and link
        //create a link for the image view in firebase
        // go to firebase reference
       
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


