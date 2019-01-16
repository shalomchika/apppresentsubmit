//
//  InitialNavViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 10/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit

// git is a version control
// github bitbucket gitlab
// save yo

class InitialNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var isloggedin = UserDefaults.standard.bool(forKey: "didlogin")
        
        if isloggedin == false {
            var vc = FeedViewController() //change this to your class name
            viewControllers = [vc]
//            self.present(vc, animated: true, completion: nil)
        }
        else {
            var vc = LoginViewController()
            //self.present(vc, animated: true , completion: nil)
            viewControllers = [vc]
            //change this to your class name
        }
 
 

        // Do any additional setup after loading the view.
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
