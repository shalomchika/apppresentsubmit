//
//  GiftPopUpViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 04/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit

class GiftPopUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
  

 
    
    @IBOutlet weak var clothestextfield: UITextField!
    @IBOutlet weak var shoetextfield: UITextField!
    let clothessizes = ["UK 4","UK 6", "UK 8", "UK 10","UK 12", "UK 14", "UK 16", "UK 18", "UK 20", "UK 22", "UK 22", "UK 24", "UK 26", "UK 28"]
    
        let shoesizes = ["UK 2","UK 3", "UK 4", "UK 5","UK 6", "UK 7", "UK 8", "UK 9", "UK 10", "UK 11", "UK 12", "UK 13", "UK 14", "UK 15","UK 16"]
    //shoe sizes boundaries found online
    var currenttextfield = UITextField()
    var pickerview = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
    self.view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closepopup(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if currenttextfield == clothestextfield {
            return clothessizes[row]
        } else {
            return shoesizes[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if currenttextfield == clothestextfield {
        return clothessizes.count
        } else {
            return shoesizes.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currenttextfield == clothestextfield {
            clothestextfield.text = clothessizes[row]
            self.view.endEditing(true)
        } else  if currenttextfield == shoetextfield{
            shoetextfield.text = shoesizes[row]
             self.view.endEditing(true)
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerview.delegate = self
           self.pickerview.dataSource = self
        currenttextfield = textField
        if currenttextfield == clothestextfield {
            currenttextfield.inputView = pickerview
        } else if currenttextfield == shoetextfield {
            currenttextfield.inputView = pickerview
        }
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
