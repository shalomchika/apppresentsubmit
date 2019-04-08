//
//  UploadPostViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 08/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

//https:www.youtube.com/results?search_query=Instagram-like+App+Ep+2%3A+Upload+Post+to+Firebase+(with+Swift+3+and+XCode+8)
class UploadPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var collection: UITextField!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var postbtn: UIButton!
    @IBOutlet weak var selectbtn: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var picker = UIImagePickerController()
    var selectedimage : UIImage?
    
    static func create() -> UploadPostViewController {
        return UIStoryboard(name: "post", bundle: nil).instantiateViewController(withIdentifier: "UploadPostViewController") as! UploadPostViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        picker.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        postbtn.setCorner(radius: 7)
        postbtn.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        
        backButton.imageView?.changeColor(to: .black)
        previewImage.image = UIImage(named: "image_add_button")
        //previewImage.contentMode = .scaleAspectFit
        captionTextView.delegate = self
        
        
        
       
  
    }
    // sorry I have to run! message you on my way thanks sorry I was late
    

    @IBAction func selectPressed(_ sender: Any) {
        
        //show picker
        //picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        self.present(picker,animated: true , completion: nil)
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        captionTextView.text = " "
        captionTextView.textColor = UIColor.black
    }
    
    //give image that the user selected
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //go info image dictionary get the image and put in display
        
        self.picker.allowsEditing = true
        var image : UIImage!
        
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            image = img
            
        }
        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            image = img
        }
        
/*
        
        if let image  = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            previewImage.contentMode = .scaleAspectFit
            previewImage.image = image
        }
        else {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
           
    }
 */
        
        
       
        backButton.imageView?.changeColor(to: .white)
        //previewImage.contentMode = .scaleAspectFit
        previewImage.backgroundColor = UIColor.black
        selectedimage = image
        picker.dismiss(animated: true, completion: nil)
        self.previewImage.image = image
        //pickdismiss(animated: true, completion: nil)
        postbtn.isHidden = false
        }
        

    
    @objc func goBack() {
        self.dismiss(animated: true, completion: nil)
        navigationController?.dismiss(animated: true, completion: nil)
       // navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func postPressed(_ sender: Any) {
        guard let userid = Auth.auth().currentUser?.uid else { return }
        let name = Database.database().reference().child("userid")
        var feedname : String?
        
        
        let nameDB = Database.database().reference().child("users").child("userid")
        
        nameDB
            .observeSingleEvent(of: .value) { [weak self] (snapshot) in
                        
                var snapshotvalue = snapshot.value as? NSDictionary
                        
                if var displayname = snapshotvalue?["fullname"] as? String {
                    feedname = displayname
                }
        
        
        }
        
        
        
        
        
        let postId = String(Date().timeIntervalSince1970).replacingOccurrences(of: ".", with: "") + userid
        let postDb = Database.database().reference().child("posts").child(postId)
        var  caption = captionTextView.text
        let feed = ["userID": userid,
                    //"likes": 0,
                    "caption" : caption,
                    //"albumname": "set album name",
                    "timestamp": Date().timeIntervalSince1970,
                    "postID": postId] as [String : Any]
        postDb.setValue(feed)
        let storage = Storage.storage().reference(forURL: "gs://apppresent.appspot.com")
        if let data = previewImage.image!.jpegData(compressionQuality: 0.6) {
            let imageRef = storage.child("posts").child(postId)
            imageRef.putData(data, metadata: nil) { (metadata, err) in
                imageRef.downloadURL(completion: { (url, downloadErr) in
                    if let downloadUrl = url?.absoluteString {
                        postDb.child("pathToImage").setValue(downloadUrl)
                    }
                })
            }
        }
        
        
        
        
        
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
    goBack()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
//https://stackoverflow.com/questions/31107994/how-to-only-show-bottom-border-of-uitextfield-in-swift

//https://stackoverflow.com/questions/27652227/text-view-placeholder-swift

extension UITextField {
    
    
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect.init(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        let colourblue = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        bottomLine.backgroundColor = colourblue.cgColor
        self.borderStyle = UITextField.BorderStyle.bezel
        self.layer.addSublayer(bottomLine)
        
    }
}
