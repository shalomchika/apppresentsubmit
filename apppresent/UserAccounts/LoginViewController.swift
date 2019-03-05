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

extension UIViewController {
    static func create<T>(fromStoryboard name: String) -> T {
        let id = String(describing: self)
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: id) as! T
    }
}


class LoginViewController: UIViewController {

    static func create() -> LoginViewController {
        return UIStoryboard(name: "login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    @IBOutlet weak var emailtextfield: UITextField!
    @IBOutlet weak var passwordtextfield: UITextField!
    @IBOutlet weak var loginbtn: UIButton!
    @IBOutlet weak var registerbtn: UIButton!
    @IBOutlet weak var errormessagelbl: UILabel!
    var doesexist:Bool = false
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "APP PRESENT"
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
        
        registerbtn.setRounded(radius: 10)
        
        // circle => set radius = width / 2; width = height
        
        setupView()
        
        
        
      
        
        
        
    }
    
    func setupView() {
        let radius: CGFloat = 5
        
        let textFont = UIFont.systemFont(ofSize: 16)
        emailtextfield.font = textFont
        passwordtextfield.font = textFont
        
        let boldFont = UIFont.boldSystemFont(ofSize: 20)
        
        loginbtn.backgroundColor = UIColor.c_102_100_247
        loginbtn.setTitleColor(.white, for: .normal)
        loginbtn.setCorner(radius: radius)
        loginbtn.titleLabel?.font = boldFont
        
        registerbtn.backgroundColor = UIColor.white
        registerbtn.setBorder(0.5, color: .c_102_100_247)
        registerbtn.setTitleColor(.c_102_100_247, for: .normal)
        registerbtn.setCorner(radius: radius)
        registerbtn.titleLabel?.font = boldFont
        
    }
    

    @IBAction func login(_ sender: Any) {
        hideKeyboard()
        // show progress indicator https://github.com/pkluz/PKHUD
        //self.checkemailexists()
        
        Auth.auth().signIn(withEmail: emailtextfield.text!, password: passwordtextfield.text!) { (user, error) in
            
            if error != nil {
                self.errormessagelbl.text = error!.localizedDescription
                self.errormessagelbl.sizeToFit()
                return
            }
            
            if user != nil {
                print("User has logged in")
                self.performSegue(withIdentifier: "tabdetail", sender: user)
            }
            
            // I changed the code so I need to make it go back, but the main thing is
                
               Setting.didLogin = true
            }
        }
    
    /*DELETE UNLES USE TO EXPLAIN
    func checkIfEmailExists(exists: Bool) -> Bool {
        
       var exists  = exists
        let ref = Database.database().reference().child("users")
        
        let email = emailtextfield.text ?? ""
        
     //1
       
        
            // 5. Received the result from the async function,
            //    now do whatever you want with it:
           
      ref
            .queryOrdered(byChild: "email").queryEqual(toValue: email) // 2
            .observe(.value, with: { (snapshot: DataSnapshot) in
                // 3
                if (snapshot.exists()){
                print(snapshot)
           
                //self.errormessagelbl.text = "An email exists with this account"
                    self.errormessagelbl.sizeToFit()
                     var thisexists = true
                    
                    
                    //code is a bit messy but it is meant to check if email exists and if that snapshot in firebase exists (that works I believe) but because it is asychronous I havent got the variable to work that it exists and show the register view controller
                    exists = thisexists
                    
                    self.doesexist  = true
                    print ("DOES IT CAPTURE")
                    var thistry = true
                    //print (thistry)
                    //print (thisexists)
                   // print (exists)
                    self.doesexist = true
                   
                    
                   // self.errormessagelbl.text = (String(exists))
                  
                }
                
                else {
                  
                    var thisexists = false
                    exists = thisexists
                    self.shouldregister()
                  
                }
                /*
                // 1. Call helloCatAsync passing a callback function,
                //    which will be called receiving the result from the async operation
                helloCatAsync(function(result) {
                    // 5. Received the result from the async function,
                    //    now do whatever you want with it:
                    alert(result);
                });
 
 */
                
              
            
            })
        
        


        return exists
     
    }
 
 
 */
        

    

    @IBAction func register(_ sender: Any) {
        // remove this ¸¸¸¸contnet
        // move content of sholdRegister to her e
        
        shouldregister()
        return
        /*DELETE USE TO EXPLAIN?
        self.errormessagelbl.text = ""
        var resultexists = self.checkIfEmailExists(exists: doesexist)
        print("HERE! IF IT IS BACK CORRECT")
        print(resultexists)
        //self.errormessagelbl.text = (String(resultexists))
    
        if resultexists == true {
            let messageexist =  "email exists already"
            errormessagelbl.text  = messageexist
            self.errormessagelbl.sizeToFit()
            return
            
        }
        
        if resultexists == false  {
            
            print(resultexists)
            self.errormessagelbl.text  = " "
           // let vc  = RegisterDetailVCViewController()
         //   self.present(vc, animated: true, completion: nil)
            //errormessagelbl.text = "false"
    
        }
 */
    }
//how do I tell the user they cant register because the email exists using firebases checking
    func shouldregister () {
        // hie keyboard
        // show progress indicator https://github.com/pkluz/PKHUD
        
        let email = emailtextfield.text!
        let password = passwordtextfield.text!
        Auth.auth().createUser(withEmail: emailtextfield.text!, password: passwordtextfield.text!) { (user, error) in
            if error != nil {
                self.errormessagelbl.text = error!.localizedDescription
                return
            }
            
            if user != nil {
                
                
                let uid = user?.user.uid ?? "new_value"
                
                
                
                self.saveToFirebase(userid: uid, email: email)
                let controller = RegisterDetailVCViewController.create()
                self.navigationController?.pushViewController(controller, animated: true)
                
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
        //let ref = Database.database().reference()
        
        //let usersReference = ref.child("users")
        //let newUsersReference = usersReference.child(uid!)
        
        // userId => UID
        // email
        // birhtday
        // avatar
        // ...
        
        //user/_your_id/email|password
        
        // if you use this, in case you want to change user -> myUsers , you have to go everywhere to change
        // ref.child("musers").child(userid).setValue(["email": email, "user_id" : userid])
        
     
        
        //if you use this, you just change 1 place
        let rf = DatabaseNode.getDb(.users)
        rf.child(userid).setValue(["email": email, "user_id" : userid])
    }
}

