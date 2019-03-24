//
//  ReferralPopup.swift
//  apppresent
//
//  Created by Macbook Pro on 06/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import Foundation
import UIKit
import Firebase
//https:www.codementor.io/nguyentruongky33/ui-implementation-popup-qqq2zbdsg

class ReferralPopup: knView {
    
    let blackView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return button
    }()
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.createRoundCorner(7)
        return v
    }()
    let okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let color = UIColor.color(r: 241, g: 66, b: 70)
        button.backgroundColor = color
        button.setTitle("NOTED!", for: .normal)
        button.backgroundColor = UIColor.color(r: 71, g: 204, b: 54)
        button.height(54)
        button.createRoundCorner(27)
        return button
    }()
    
    
    let shoesSizeLabel = UIMaker.makeLabel(font: UIFont.boldSystemFont(ofSize: 25), color: UIColor.c_102_100_247, alignment: .center)
    let clothesSizeLabel = UIMaker.makeLabel(font: UIFont.boldSystemFont(ofSize: 25), color: UIColor.c_102_100_247, alignment: .center)
    
    // wanted the current user to edit their clothes and shoe size ( I had the code for it before but not with the correct UI)
    // How to use UI with that code.
    // User adds size with date pickers
    // other user sees it as labels?
    // simplest way to do that?
    
    //if you know how to change the pop UI to textfields I can make the current user work?
    // we can do the other users view later?
    
    
    // in edit rpofile
    // add one section
    //is that a table view, right now I just have text fields? Can I keep the textfields?//
    // I have to chagne edit profile to a table view? for better format? why? why?
    // to show and hide keyboard table view - table view will handle the keyboard for me , easier to scroll.
    /*
     
     
     
     
     let shoesizes = ["Shoe size - detective work", "UK 2","UK 3", "UK 4", "UK 5","UK 6", "UK 7", "UK 8", "UK 9", "UK 10", "UK 11", "UK 12", "UK 13", "UK 14", "UK 15","UK 16"]
     //shoe sizes boundaries found online
     var currenttextfield = UITextField()
     var pickerview = UIPickerView()
     
     
    let shoeTextfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        let color = UIColor.white
        textfield.backgroundColor = color
        textfield.text = "set shoesize variable"
        textfield.backgroundColor = UIColor.color(r: 71, g: 204, b: 54)
        textfield.height(40)
        textfield.createRoundCorner(27)
        return textfield
    }()
    
    let clothesTextfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        let color = UIColor.white
        textfield.backgroundColor = color
        textfield.text = "set clothesize variable"
        textfield.backgroundColor = UIColor.color(r: 71, g: 204, b: 54)
        textfield.height(40)
        textfield.createRoundCorner(27)
        return textfield
    }()
 
     
     func detailtoFirebase() {
     var ref: DatabaseReference!
     ref = Database.database().reference()
     let currentUser = Auth.auth().currentUser
     let userid = currentUser!.uid
     
     var csize  = clothestextfield.text ?? "Detective work"
     var ssize = shoetextfield.text ?? "Detective work"
     
     
     var ssizedata = [String: String]()
     var csizedata = [String: String]()
     //ssizedata["shoesize"] = ssize
     //csizedata["clothessize"] = csize
     ref = ref.child("users").child(userid)
     ref.updateChildValues(["shoesize": ssize,
     "clothessize": csize])
     // create these nodes in firebase
     
     
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
     
 */
    // thats the code for the edir profile page, I took it from a different branch.
    func show(in view: UIView) {
        addSubviews(views: blackView, container)
        blackView.fill(toView: self)
        container.centerY(toView: self)
        container.horizontal(toView: self, space: 24)
        
        blackView.alpha = 0
        UIView.animate(withDuration: 0.1, animations:
            { [weak self] in self?.blackView.alpha = 1 })
        container.zoomIn(true)
        
        view.addSubviews(views: self)
        fill(toView: view)
    }
    
    
    @objc func dismiss() {
        let initialValue: CGFloat = 1
        let middleValue: CGFloat = 1.025
        let endValue: CGFloat = 0.001
        func fadeOutContainer() {
            UIView.animate(withDuration: 0.2, animations:
                { [weak self] in self?.container.alpha = 0 })
        }
        func zoomInContainer() {
            UIView.animate(withDuration: 0.05,
                           animations: { [weak self] in self?.container.scale(value: middleValue) })
        }
        func zoomOutContainer() {
            UIView.animate(withDuration: 0.3, delay: 0.05, options: .curveEaseIn,
                           animations:
                { [weak self] in
                    self?.container.scale(value: endValue)
                    self?.blackView.alpha = 0
                }, completion: { [weak self] _ in self?.removeFromSuperview() })
        }
        
        container.transform = container.transform.scaledBy(x: initialValue , y: initialValue)
        fadeOutContainer()
        zoomInContainer()
        zoomOutContainer()
    }
    
    override func setupView() {
        let color = UIColor.color(r: 241, g: 66, b: 70)
        
        let instruction = "Now about my healthy SIZE..."
        let label = UIMaker.makeLabel(text: instruction,
                                      font: UIFont.boldSystemFont(ofSize: 15),
                                      color: .white,
                                      alignment: .center)
        
        let circle = UIMaker.makeView(background: color)
        let logo = UIMaker.makeImageView(image: UIImage(named: "mannequin"), contentMode: .scaleAspectFit)
        logo.backgroundColor = .white
        
        let codeTitle = UIMaker.makeLabel(text: "PREFERENCES ARE...",
                                          font: UIFont.boldSystemFont(ofSize: 12),
                                          color: UIColor.color(r: 155, g: 165, b: 172),
                                          alignment: .center)
        
       
            /*
            
            func loadData() {
                
                let userid = Auth.auth().currentUser?.uid
                var ref = Database.database().reference()
                ref.child("users").child(userid ?? "").observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    let value = snapshot.value as? NSDictionary
                    let shoesize = value?["shoesize"] as? String ?? ""
                    let clothessize = value?["clothessize"] as? String ?? ""
                    
                    self.clothesTextfield.text = clothessize
                    self.shoeTextfield.text = shoesize
                    
                    
                })
 */
        
        
        let shoesTitle = UIMaker.makeLabel(text: "Shoes size", font: UIFont.systemFont(ofSize: 15), color: .black)
        let clothesTitle = UIMaker.makeLabel(text: "Shoes size", font: UIFont.systemFont(ofSize: 15), color: .black)
        
        
        container.addSubviews(views: circle, label, okButton, logo, codeTitle)
        container.addSubviews(views: shoesTitle, shoesSizeLabel, clothesTitle, clothesSizeLabel)
        
        // (1)
        label.top(toView: container, space: 24)
        label.horizontal(toView: container, space: 24)
        
        // (2)
        let edge: CGFloat = UIScreen.main.bounds.width * 2
        circle.square(edge: edge)
        circle.createRoundCorner(edge / 2)
        circle.centerX(toView: container)
        circle.bottom(toAnchor: logo.centerYAnchor)
        
        // (3)
        let logoEdge: CGFloat = 66
        logo.square(edge: logoEdge)
        logo.centerX(toView: circle)
        logo.verticalSpacing(toView: label, space: 40)
        logo.createRoundCorner(logoEdge / 2)
        logo.createBorder(1, color: color)
        
        // (4)
        codeTitle.centerX(toView: container)
        codeTitle.verticalSpacing(toView: logo, space: 24)
        
        // (5)
        
        shoesTitle.left(toView: container, space: 24)
        shoesTitle.verticalSpacing(toView: codeTitle, space: 24)
        
        shoesSizeLabel.centerX(toView: container)
        shoesSizeLabel.bottom(toView: shoesTitle, space: 2)
        
        clothesTitle.left(toView: shoesTitle)
        clothesTitle.bottom(toView: clothesSizeLabel)
        
        clothesSizeLabel.centerX(toView: container)
        clothesSizeLabel.verticalSpacing(toView: shoesSizeLabel, space: 24)
        
        // (6)
        okButton.verticalSpacing(toView: clothesSizeLabel, space: 24)
        okButton.bottom(toView: container, space: -24)
        okButton.horizontal(toView: container, space: 36)
        okButton.createRoundCorner(28)
        
        okButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        blackView.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        
        
        
        shoesSizeLabel.text = "UK 5"
        clothesSizeLabel.text = "UK 5"
    }
   
}

