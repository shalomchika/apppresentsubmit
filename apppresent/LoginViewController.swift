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
    @IBOutlet weak var loginbtn: UIButton!
    @IBOutlet weak var registerbtn: UIButton!
    @IBOutlet weak var errormessagelbl: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        
        emailtextfield.layer.cornerRadius = 5
        emailtextfield.layer.borderColor = UIColor.red.cgColor
        //emailtextfield.layer.borderWidth = 1
        loginbtn.layer.borderWidth = 0.5
        loginbtn.layer.cornerRadius = 5
        loginbtn.titleLabel?.textColor = .black
        //error
        //loginbtn.layer.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 1.0, alpha: 0.9)
        loginbtn.layer.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        loginbtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginbtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        registerbtn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        registerbtn.layer.cornerRadius = 5
        registerbtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        registerbtn.layer.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        registerbtn.titleLabel?.textColor = .black
        registerbtn.layer.borderWidth = 0.5
        

        
        
        
        
      
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var logpersistent = UserDefaults.standard.bool(forKey: "didlogin")
       /*
        if logpersistent == true {
        self.performSegue(withIdentifier: "tabdetail", sender: nil)
          //let vc = FeedViewController()
            
          // self.present(vc, animated: true, completion: nil)
         //   print(logpersistent)
        }
        */
        
    }

    @IBAction func login(_ sender: Any) {
        var emailaddress = self.emailtextfield.text!
        print(emailaddress)
        
        
        //self.checkemailexists()
        
        Auth.auth().signIn(withEmail: emailtextfield.text!, password: passwordtextfield.text!) { (user, error) in
            if user != nil {
                print("User has logged in")
                
                self.performSegue(withIdentifier: "tabdetail", sender: user)
            }
            
            if error != nil {
            
                self.errormessagelbl.text = "Incorrect password or email"
                
                }
                
               
            }
        }
    
    func checkIfEmailExists(exists: Bool) -> Bool {
        
       var exists  = exists
        let ref = Database.database().reference().child("users")
        
        let email = emailtextfield.text ?? ""
        
     //1
        
      ref
            .queryOrdered(byChild: "email").queryEqual(toValue: email) // 2
            .observe(.value, with: { (snapshot: DataSnapshot) in
                // 3
                if (snapshot.exists()){
                print(snapshot)
           
                self.errormessagelbl.text = "Email exists"
                var thisexists = true
                    
                    exists = thisexists
                    print ("DOES IT CAPTURE")
                    var thistry = true
                    print (thistry)
                    print (thisexists)
                    print (exists)
                    self.errormessagelbl.text = (String(exists))
                  
                }
                
                
              
            
            })
        


      
        return exists
    }
                
        

    

    
    /*
    func checkemailexists() {
         var emailaddress = emailtextfield.text!
        Auth.auth().fetchProviders(forEmail: emailaddress , completion: {
            (providers, error) in
            print("CHECK")
            print(emailaddress)
            if let error = error {
                    print("not found")
                self.errormessagelbl.text = "There is no email linked with this account"
                
                self.errormessagelbl.sizeToFit()
                print(error.localizedDescription)
            }
            else if var providers =  {
                //self.errormessagelbl.text = "There is no email linked with this account"
                
                self.errormessagelbl.text = ""
                self.errormessagelbl.text = "There is no email linked with this account"
                print ("PROVIDERS")
                print(providers)
                
            }
            
        })
    }
 */

    @IBAction func register(_ sender: Any) {
       
        
        var exists: Bool = false
        var resultexists = self.checkIfEmailExists(exists: exists)
        //self.errormessagelbl.text = (String(resultexists))
        print("REGISTER EMAIL EXIST")
        print (resultexists)
        if resultexists == true {
            return
            
        }
        
        else if resultexists == false  {
            errormessagelbl.text = " "
            shouldregister()
        }
    }
    
    func shouldregister () {
        
        let email = emailtextfield.text!
        let password = passwordtextfield.text!
        Auth.auth().createUser(withEmail: emailtextfield.text!, password: passwordtextfield.text!) { (user, error) in
            if user != nil {
                
                
                let uid = user?.user.uid ?? "new_value"
                
                
                
                self.saveToFirebase(userid: uid, email: email)
                
                // let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                // let registerdetailVC = storyboard.instantiateInitialViewController(withIdentifier: "RegisterDetailVC")
                // let regDetVC =  self.navigationController?.pushViewController(registerdetailVC, animated: true)
                
                ///let vc  = FeedViewController()
                  //self.performSegue(withIdentifier: "registerdetail", sender: nil)
                
             //  let vc = RegisterDetailVCViewController self.navigationController?.pushViewController(RegisterDetailVCViewController, animated: true)
              
            }
            
            
            if error != nil {
                print (error?.localizedDescription)
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

