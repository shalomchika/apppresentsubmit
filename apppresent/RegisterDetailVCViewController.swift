//
//  RegisterDetailVCViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 22/12/2018.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class RegisterDetailVCViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    static func create() -> RegisterDetailVCViewController {
        return UIStoryboard(name: "register", bundle: nil).instantiateViewController(withIdentifier: "RegisterDetailVCViewController") as! RegisterDetailVCViewController
    }

    @IBOutlet weak var firstnametextfield: UITextField!
    @IBOutlet weak var lastnametextfield: UITextField!
    @IBOutlet weak var birthdaytextfield: UITextField!
    @IBOutlet weak var registerstatus: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var tapimagebtn: UIButton!
    @IBOutlet weak var profileimageview: UIImageView!
    var selectedimage : UIImage?
    
    //let userid = Auth.auth().currentUser!.uid
    let datePicker = UIDatePicker()
    var imagePicker = UIImagePickerController()
    var age = 0
    var birthday = ""
    var status = ""
    var profileImageUrl = ""
    var firstname = ""
    var lastname = ""
    //var selectedImage = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       /*
        do
        {
            try Auth.auth().signOut()
        }
        catch let error as NSError
        {
            print (error.localizedDescription)
        }
        */
        //profileimageview.layer.cornerRadius = 40 //
        profileimageview.clipsToBounds = true //
        birthdaytextfield.inputView = datePicker
        firstnametextfield.delegate = self
        lastnametextfield.delegate = self
        birthdaytextfield.delegate = self
        registerstatus.delegate = self
        imagePicker.delegate = self
      
        
        
        datePicker.datePickerMode = .date
        
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        tapimagebtn.addTarget(self, action: #selector(handlePickImage), for: .touchUpInside)
        let ref = Database.database().reference()
        //ref.child("users").childByAutoId().setValue("testing2")//move ?
      
    
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
        
        
        print(age)
        print(month)
        print(day)
        print(minute)
        print(birthday)

        
        
        
       // self.saveToFirebase (birthday: birthday, age: age) //move to continue button
        
        
        // calculate next birhtday
        //
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
        
        
        // Set photoImageView to display the selected image.
        profileimageview.contentMode = .scaleAspectFit
        profileimageview.layer.cornerRadius = 40
        profileimageview.image = image
        selectedimage = image
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
        
    
    
   /* func showScreen() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Your_Contorller_id")
        present(controller, animated: true)
    }
    */
    // save to firebase
    
    
    //func numberOfComponents(in pickerView: UIPickerView) -> Int {
       // return componentNumber
   // }
    

    func convertDateToString(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func saveToFirebase(firstname: String, lastname: String, birthday: String, age: Int, status: String, profileImageUrl: String) {
        
        print("User has registered in")
        
        //https:www.youtube.com/watch?v=OEUeGuBnNAs
       // let ref = Database.database().reference()
        //let usersReference = ref.child("users")
        //let newUsersReference = usersReference.child(uid!)
        
        //user/_your_id/email|password
        let userid = Auth.auth().currentUser!.uid
        
       
        
        let storageRef  = Storage.storage().reference().child("user/\(userid)")
        //
        // if let
        // guard let => ?
        if let uploadData = selectedimage!.jpegData(compressionQuality: 0.1){
//            Data
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
                    if let profileImageUrl = url?.absoluteString {
                        print(profileImageUrl)
                        //creates a profile image url which is stored in global variable
                        //how I should upload to Firebase
                        //   let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
                        //   self.registeUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                        var ref = Database.database().reference().root
                        ref = ref.child("users").child(userid)
                        ref.updateChildValues(["firstname": firstname,
                                                "lastname": lastname,
                                               "birthday": birthday,
                                               "age" : age,
                                               "status": status,
                                               "profileImageUrl": profileImageUrl])
                    }
                })
            })
        }
        
        
    //let ref = FIRDatabase.database().reference().root.child("users").child(uid).child(getDate()).updateChildValues(["Places": values])
        
        //replaces the whole node
        //ref.child("users").child(userid).setValue(["birthday": birthday, "age" : age])
    
}
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
   /* func uploadProfileImage(_ image: UIImage, completion: @escaping((_ url: String?) -> ())) {
             //guard let uid = Auth.auth().currentUser?.uid else {return}
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        let storageRef  = Storage.storage().reference().child("user/\(userid)")
        //store profile image stored at uid file path
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
       // guard let imageData = UIImageJPEGRepresentation(selectedimage, 0.75) else {return}
        guard let imageData = selectedimage.jpegData(compressionQuality: 0.85) else {return}
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil{
                // success!
                //get downoad url
                let pathURL = self.selectedimage.accessibilityPath
                storageRef.downloadURL {pathURL, error in
                    completion(pathURL)
                }
            } else {
                completion(nil)
            }
            
        }
 
        
    
    */
    
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
                if let profileImageUrl = url?.absoluteString {
                    print(profileImageUrl)
//creates a profile image url which is stored in global variable
                    //how I should upload to Firebase
                 //   let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
                 //   self.registeUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                }
            })
        })
        }
    }
    
    @IBAction func continueB(_ sender: Any) {
        firstname = firstnametextfield.text ?? "Me"
        lastname = lastnametextfield.text ?? "Me"
        status = registerstatus.text ?? "Celebration time"
        saveToFirebase(firstname: firstname, lastname: lastname, birthday: birthday,age: age, status: status, profileImageUrl: profileImageUrl)
      // self.uploadProfileImage(<#T##image: UIImage##UIImage#>, completion: <#T##((String?) -> ())##((String?) -> ())##(String?) -> ()#>)
        
    }
}

extension RegisterDetailVCViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == birthdaytextfield {
            
        }
    }
}
