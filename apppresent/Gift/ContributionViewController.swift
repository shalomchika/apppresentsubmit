//
//  ContributionViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 23/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class ContributionViewController: UIViewController {
    
    static func create() -> ContributionViewController {
        return UIStoryboard(name: "gifting", bundle: nil).instantiateViewController(withIdentifier: "ContributionViewController") as! ContributionViewController
    }

    @IBOutlet weak var linkTextfield: UITextField!
    
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.addTarget(self, action: #selector(dismissView ), for: .touchUpInside)
        updateButton.addTarget(self, action: #selector(updateLink), for: .touchUpInside)
        // Do any additional setup after loading the view.
        updateButton.setCorner(radius: 7)
        updateButton.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        
    }
    
    @objc func updateLink() {
       
        let link = linkTextfield.text
        
        guard let userid = Auth.auth().currentUser?.uid else { return }
        let linkDb = Database.database().reference().child("pools").child(userid)
        //var caption = captionlbl.text
        let item = [
                    "owner": userid,
                    "link": link,
                    "created": Date().timeIntervalSince1970]
            as [String : Any?]
        linkDb.setValue(item)
        dismissView()
    }
    
    @objc func dismissView()  {
             dismiss(animated: true)
        
     
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
