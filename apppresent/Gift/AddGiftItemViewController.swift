//
//  AddGiftItemViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 23/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
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
        saveButton.backgroundColor = UIColor.c_102_100_247
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
        
        giftLinkTextfield.setBorder(1, color: .lightGray)
        giftLinkTextfield.setCorner(radius: 7)
        
        saveButton.setCorner(radius: 7)
        giftImageView.image = UIImage(named: "camera")
        giftImageView.contentMode = .scaleAspectFit
    }
    
    
    @objc func handlePickImage(picker: UIImagePickerController) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            
        }
        // I need to do the firebase and view controller for the link button at the top
        // put the the more button in the navigation controller
        // put it in view will appear for profile edit, and feed view controller
        //delete for post, try delete for gift
        // reminders for day and month?
        //hide my age
        //edit profile to show the date
        
        //shoe and clothes size - edit programatically to show to labels and change the colour of the red bit.
        
        //Issues:
        // the following button doesnt press and unpress
        
        
        // if its complicated I might just leave it
        // I will change everyday to on the day so its not annoying I think on every week and on the day is fine and every month
        
        
        // need to finish it by mon/tuesday mainly
        
        // After that user testing and small v.small changes i.e. the icons etc. for a week
        
        
        //
        //put back button on reminder
        
        
        
        // how difficult is to put a header on the feed, or show the author somehow?
        // should I do that in profile too? why not? im not goign to move it but why?
        // so to utlise the UI space
        // if it will take time, if not I will leave it .
        // Should I try the empty page stuff? dont think its that important?
        //thank you!
        // do I need to edit the reminders, I know it works for monthly, but the weekly and on the day?
        //when I switch the button off doesnt it cancel it already?
        // Do I need to delete post or gift .... I dont know how complicated that is
        // the reason why the post is not showing in the feed immediately is because of view will appear?
        //when I edit profile and it doesnt show imediately it is view will appear?
        //Last stuff
        // At last time as well I may put this
        //I could get them to hold on the image or do I have to put a header? or a button like shop in the gift controller
        
        
        // Set photoImageView to display the selected image.
        giftImageView.contentMode = .scaleAspectFit
        //profileimageview.layer.cornerRadius = 40
        giftImageView.image = image
        //selectedimage = image
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
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
        
        guard let userid = Auth.auth().currentUser?.uid else { return }
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
        if let data = giftImageView.image!.jpegData(compressionQuality: 0.6) {
            let imageRef = storage.child("gifts").child(id)
            imageRef.putData(data, metadata: nil) { (metadata, err) in
                imageRef.downloadURL(completion: { (url, downloadErr) in
                    if let downloadUrl = url?.absoluteString {
                        giftDb.child("imageUrl").setValue(downloadUrl)
                        self.dismiss(animated: true)
                    }
                })
            }
        }
        
        /*
        @objc func goBack() {
            self.dismiss(animated: true, completion: nil)
            navigationController?.dismiss(animated: true, completion: nil)
            // navigationController?.popViewController(animated: true)
        }
        */
        
        /*
         
         let storage = Storage.storage().reference(forURL: "gs://apppresent.appspot.com")
         //id for a post, go to databse ref create new branch called post give post unique IF
         //        var key = ref.child("post").childByAutoId().key
         // created a file .jpg with the name of the post which will be unique
         let imageRef = storage.child("post").child(userid).child("\(key).jpg")
         
         //upload image to database
         //convert to data
         let data = previewImage.image!.jpegData(compressionQuality:0.6)
         
         let uploadTask = imageRef.putData(data!, metadata: nil) { (metadata, error) in
         if error != nil {
         print(error!.localizedDescription)
         return
         }
         
         imageRef.downloadURL(completion: { (url, error) in
         //get and check download url
         if let url = url {
         let feed = ["userID": userid,
         "pathToImage": url.absoluteString,
         "likes": 0,
         "caption" : "set caption",
         "collectionID": "set collectionID",
         "author": Auth.auth().currentUser!.displayName ?? "set it",
         "timestamp": ServerValue.timestamp() as! [String : Any],
         "postID": key ?? "none"] as [String : Any]
         ]
         //create key under the post IFput all the sfeed
         let postfeed = ["\(key)" : feed]
         ref.child("post").updateChildValues(postfeed)
         self.dismiss(animated: true, completion: nil)
         }
         })
         }
         
         */
        //uploadTask.resume()
        
        
    }
    
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


