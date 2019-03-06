//
//  EditProfileViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 02/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import Kingfisher


class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static func create() -> EditProfileViewController {
        return create(fromStoryboard: "profile")
    }
    
    // when I change the image  in edit profile, you change the image view in PriflePgeCOntorller
    //
    // ProfilePageViewCOntroller HAS EditProfilePageController
    // EditProfilePageController has ProfilePageViewCOntroller
    
    //https://medium.com/flawless-app-stories/memory-leaks-in-swift-bfd5f95f3a74
    //https://medium.com/mackmobile/avoiding-retain-cycles-in-swift-7b08d50fe3ef
    
    // A Strong B
    // B Strong A
    // retain cycle =? never relase memory here =? leak memory
    
    weak var profilePage: ProfilePageViewController?
    var myProfile: UserData?
    @IBOutlet weak var datepickercompletionlbl: UILabel!
    
  
    @IBOutlet weak var firstnametextfield: UITextField!
    @IBOutlet weak var lastnametextfield: UITextField!
    @IBOutlet weak var statustextfield: UITextField!
    @IBOutlet weak var birthdaytextfield: UITextField!
    var selectedimageurl : String!
    @IBOutlet weak var emailtextfield: UITextField!
    @IBOutlet weak var tapimagebtn: UIButton!
    @IBOutlet weak var profileimageview: UIImageView!
    var selectedimage : UIImage?
    @IBOutlet weak var savebtn: UIButton!
    @IBOutlet weak var backtn: UIButton!
    
    let userid = Auth.auth().currentUser!.uid
    let datePicker = UIDatePicker()
    var imagePicker = UIImagePickerController()
    var age = 0
    var birthday = ""
    var email = ""
    var status = ""
    var profileImageUrl = ""
    var url = ""
    var firstname = ""
    var lastname = ""
    //var selectedImage = UIImage()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        profileimageview.layer.cornerRadius = 40
        profileimageview.clipsToBounds = true
        birthdaytextfield.inputView = datePicker
        firstnametextfield.delegate = self
        lastnametextfield.delegate = self
        birthdaytextfield.delegate = self
        statustextfield.delegate = self
        imagePicker.delegate = self
        birthdaytextfield.inputView = datePicker
        datePicker.datePickerMode = .date
        
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        tapimagebtn.addTarget(self, action: #selector(handlePickImage), for: .touchUpInside)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        loadProfileData()
        
      
        
        
        
        // Do any additional setup after loading the view.
    }
    

    func loadProfileData(){
        firstnametextfield.text = myProfile?.firstname
        profileimageview.downloadImage(from: myProfile?.profileimageurl)
        
        /*
        let ref = Database.database().reference()
        // Do any additional setup after /loading the view.
        
        let userid = Auth.auth().currentUser?.uid
        ref.child("users").child(userid ?? "").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let firstname = value?["firstname"] as? String ?? ""
            let lastname = value?["lastname"] as? String ?? ""
            let age = value?["age"] as? Int ?? 0
            let status = value?["status"] as? String ?? ""
            let fullname = "\(firstname) \(lastname)"
            print (" If the profile url is there", self.profileImageUrl)
            let imageurl = value?["profileImageUrl"] as? String ?? ""
            let birthday = value?["birthday"] as? String ?? ""
            let email = value?["email"] as? String ?? ""
            print("This is age" ,age)
            let stringage = String(age)
            print(stringage)
            print(imageurl)
            print("This is status ", status)
            print(" This is fullname " ,fullname)
            
            self.firstnametextfield?.text = firstname
            self.lastnametextfield?.text = lastname
            //self.birthdaytextfield.text = stringage
            self.birthdaytextfield.text = birthday
            self.statustextfield?.text = status
            self.emailtextfield?.text = email
            
            if let url = URL(string: imageurl) {
                do {
                    // if the url matches our cache it will get the image from the cache url
                    
                    let resource = ImageResource(downloadURL: url, cacheKey: url.path)
                    self.profileimageview.kf.setImage(with: resource)
                    
                    // use king fisher load image faster
                    
                    // check kingfisher
                    //oh SD has to bridge from obj C, ok!
                    //let imageAsData = try Data(contentsOf: url)
                   // let image = UIImage(data: imageAsData)
                    //self.profileimageview.image = image
                } catch {
                    print("imageURL was not able to be converted into data") // Assert or add an alert
                }
                
            }
            print(snapshot)
        })
 */
 }

    
    
    @IBAction func saveprofilebtn(_ sender: Any) {
        
        firstname = firstnametextfield.text ?? ""
        lastname = lastnametextfield.text ?? ""
        status = statustextfield.text ?? ""
        birthday = birthdaytextfield.text ?? ""
        email = emailtextfield.text ?? ""
       
        selectedimage = profileimageview.image
        uploadProfileImage(selectedimage!) { (success) in
            
        }
        // update the profile page
        //profilePage?.profileimageview.image = profileimageview.image
       
        // update other data first
        // when uploading finihs -> update profile image
        
        var ref = Database.database().reference().root
       
        let userid = Auth.auth().currentUser!.uid
        ref = ref.child("users").child(userid)
     ref.updateChildValues(["firstname": self.firstname,
                                          "lastname": self.lastname,
                                               "birthday": self.birthday,
                                              "age" : self.age,
                                             "email" : self.email,
                                             "status": self.status,
                                            "profileImageUrl": selectedimageurl])

                        
                        // disiss current contorller
            
//            ref.child("users").child(userid ?? "").observeSingleEvent(of: .value, with: {(snapshot) in
//
//                let value = snapshot.value as? NSDictionary
//                print("LOOOOOOK")
//                print(snapshot) })
        }
    
        
        
       
        
    
        
            
        
    
    func loadview(){
        self.view.layoutIfNeeded()
    }
    
 
    
    @IBAction func savebtn(_ sender: Any) {
        
        
    }
    
    func uploadProfileImage(_ image: UIImage, completion: @escaping((_ url: String?) -> ())) {
        let userid = Auth.auth().currentUser!.uid
        let storageRef  = Storage.storage().reference().child("user/\(userid)")
        if let profileImageUrl = self.profileimageview.image , let uploadData =
            self.profileimageview.image!.jpegData(compressionQuality: 0.1){
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil, metadata != nil {
                    print(error ?? "")
                    return
                    
                }
                
                storageRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    if let profileUrl = url?.absoluteString {
                        self.selectedimageurl = profileUrl
                        
                        print(profileUrl)
                        //creates a profile image url which is stored in global variable
                        //how I should upload to Firebase
                        //   let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
                        //   self.registeUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                    }
                   
                })
               
            })
        }
        
    }
    
    @objc func handleDatePicker(picker: UIDatePicker) {
        
        birthday = convertDateToString(date: picker.date, format: "dd/MM/yyyy")
        birthdaytextfield.text = birthday
        // calculate age
        let ageInterval = Date().timeIntervalSince(picker.date)
        age = Int(ageInterval / (60 * 60 * 24 * 365))
        let month = Int(ageInterval / (60 * 60 * 24 ))
        let day = Int(ageInterval / (60 * 60 * 24 ))
        let minute = Int(ageInterval / (60 * 60 ))
        
        }
    
    @objc func handlePickImage(picker: UIImagePickerController) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            
        }
        
        profileimageview.contentMode = .scaleAspectFit
        profileimageview.layer.cornerRadius = 40
        profileimageview.image = image
        selectedimage = image
        
        profilePage?.header?.avatarImageView.image = image
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)

}
 
    
    func convertDateToString(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
 /*   @IBAction func backbtn(_ sender: Any) {

        
    }
    
    */
}
extension EditProfileViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == birthdaytextfield {
            
        }

    }
    
}

