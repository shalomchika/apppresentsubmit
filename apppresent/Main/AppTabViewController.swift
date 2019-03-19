//
//  AppTabViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 10/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit

class AppTabViewController: UITabBarController {
    static func create() -> AppTabViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UITabBarController-jNr-XU-i78") as! AppTabViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
