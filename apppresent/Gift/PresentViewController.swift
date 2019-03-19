//
//  PresentViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 18/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import Firebase


class PresentViewController: UIViewController {

    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var paymentButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func URLButtonPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.asos.com/new-look/new-look-lace-up-biker-flat-ankle-boot/prd/10240111?affid=14173&channelref=product+search&mk=abc&browsecountry=GB&currencyid=1&ppcadref=761030383%7C39786843723%7Caud-455407903566%3Apla-481059582205%26browsecountry%3DGB&_cclid=Google_Cj0KCQjwg73kBRDVARIsAF-kEH95SuhGzUhoygUKinwuKuY0GRsCI9o0kbYVa8OD4FuBR7r19R0tTSUaAnrFEALw_wcB&gclid=Cj0KCQjwg73kBRDVARIsAF-kEH95SuhGzUhoygUKinwuKuY0GRsCI9o0kbYVa8OD4FuBR7r19R0tTSUaAnrFEALw_wcB")! as URL, options:[:] , completionHandler: nil)
    }
    
    func saveEditedPresents(){
        
        
    }

    
    func uploadCollectionView() {
        
        
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
