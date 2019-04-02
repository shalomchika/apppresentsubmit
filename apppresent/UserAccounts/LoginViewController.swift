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
 
        loginbtn.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        //loginbtn.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
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
}

