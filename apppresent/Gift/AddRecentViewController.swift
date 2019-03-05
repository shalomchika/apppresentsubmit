//
//  AddRecentViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 05/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit

class AddRecentViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    @IBOutlet weak var addrecentbtn: UIButton!
    @IBOutlet weak var recentshoptxt: UITextField!
    @IBOutlet weak var recentestimatetxt: UITextField!
    @IBOutlet weak var recentimageview: UIImageView!
    var imagePicker = UIImagePickerController()
    
    
    
    
    static func create() -> AddRecentViewController {
        return UIStoryboard(name: "gifting", bundle: nil).instantiateViewController(withIdentifier: "AddRecentViewController") as! AddRecentViewController
        
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        addrecentbtn.addTarget(self, action: #selector(handlePickImage), for: .touchUpInside)
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
