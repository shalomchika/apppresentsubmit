//
//  GiftPopUpViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 04/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit

class GiftPopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
self.view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        // Do any additional setup after loading the view.
    }
    @IBAction func closepopup(_ sender: Any) {
        self.view.removeFromSuperview()
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
