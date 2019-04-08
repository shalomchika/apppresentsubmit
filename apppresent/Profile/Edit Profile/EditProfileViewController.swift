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


class EditProfileViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    @IBOutlet weak var shoesizetextfield: UITextField!
    @IBOutlet weak var clothesizetextfield: UITextField!
    
    @IBOutlet weak var hideAgeSwitch: UISwitch!
    var selectedimage : UIImage?
    @IBOutlet weak var savebtn: UIButton!
    @IBOutlet weak var backtn: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
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
    var clothesize = ""
    var shoesize = ""
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
        datePicker.datePickerMode = .date
        
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        tapimagebtn.addTarget(self, action: #selector(handlePickImage), for: .touchUpInside)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        
        
        let pickerView = UIPickerView()
        shoesizetextfield.inputView = pickerView
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadProfileData()
    }
    
    
    
    func loadProfileData(){
        
        //changed from uploading snapshot to a data structure that varies accoridng to the user
        firstnametextfield.text = myProfile?.firstname
        lastnametextfield.text = myProfile?.lastname
        emailtextfield.text = myProfile?.email
        statustextfield.text = myProfile?.status
        if let intervalString = myProfile?.birthday, let interval = Double(intervalString) {
            let date = Date(timeIntervalSince1970: interval)
            birthdaytextfield.text = date.toString("dd/MM/yyyy")
            datePicker.date = date
        }
        
        clothesizetextfield.text = myProfile?.clothesize
        shoesizetextfield.text = myProfile?.shoesize
        
        
        profileimageview.downloadImage(from: myProfile?.profileimageurl, placeholder: UIImage(named: "user_placeholder"))
        
    }
    
    
    
    @IBAction func saveprofilebtn(_ sender: Any) {
        
        firstname = firstnametextfield.text ?? ""
        lastname = lastnametextfield.text ?? ""
        status = statustextfield.text ?? ""
        if let date = newBirthdate {
            birthday = String(date.timeIntervalSince1970)
        }
        // need birthday to save as timeinterval into fire
        //birthday = birthday.timeIntervalSince1970
        
        email = emailtextfield.text ?? ""
        shoesize = shoesizetextfield.text ?? ""
        clothesize = clothesizetextfield.text ?? ""
        
        
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
                               "profileImageUrl": selectedimageurl,
                               "shoesize": shoesize,
                               "hideAge": hideAgeSwitch.isOn,
                               "clothesize": clothesize])
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func loadview(){
        self.view.layoutIfNeeded()
    }
    
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
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
    
    var newBirthdate: Date?
    
    @objc func handleDatePicker(picker: UIDatePicker) {
        
        birthday = convertDateToString(date: picker.date, format: "dd/MM/yyyy")
        birthdaytextfield.text = birthday
        newBirthdate = picker.date
        
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

