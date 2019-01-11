//
//  ViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 21/12/2018.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth



class LoginViewController: UIViewController {

    @IBOutlet weak var emailtextfield: UITextField!
    @IBOutlet weak var passwordtextfield: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 1.0, alpha: 0.9)
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @IBAction func login(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailtextfield.text!, password: passwordtextfield.text!) { (user, error) in
            if user != nil {
                print("User has logged in")
                var logpersistent = UserDefaults.standard.set(true, forKey: "didlogin")
                print (logpersistent)
                
                self.performSegue(withIdentifier: "tabdetail", sender: user)
            }

            if error != nil {
                print("There is error")
            }
            
        }
        
    }

    @IBAction func register(_ sender: Any) {
        let email = emailtextfield.text!
        let password = passwordtextfield.text!

        
        Auth.auth().createUser(withEmail: emailtextfield.text!, password: passwordtextfield.text!) { (user, error) in
            if user != nil {
            let uid = user?.user.uid ?? "new_value"
                
               
                
                self.saveToFirebase(userid: uid, email: email)
   
               // let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
               // let registerdetailVC = storyboard.instantiateInitialViewController(withIdentifier: "RegisterDetailVC")
            // let regDetVC =  self.navigationController?.pushViewController(registerdetailVC, animated: true)
                 self.performSegue(withIdentifier: "registerdetail", sender: nil)
                }
            if error != nil {
                print("There is error")
            }
    }
    }
    
    func saveToFirebase(userid: String, email: String) {
   
        
        print("User has registered in")
        
        //https:www.youtube.com/watch?v=OEUeGuBnNAs
        let ref = Database.database().reference()
        //let usersReference = ref.child("users")
        //let newUsersReference = usersReference.child(uid!)
        
        // userId => UID
        // email
        // birhtday
        // avatar
        // ...
        
        //user/_your_id/email|password
        
        ref.child("users").child(userid).setValue(["email": email, "user_id" : userid])
        
        
        
        
    }
}

