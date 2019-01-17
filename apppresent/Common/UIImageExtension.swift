//
//  UIImageExtension.swift
//  apppresent
//
//  Created by Macbook Pro on 16/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//
import UIKit
import Foundation

extension UIView {
    func setRounded(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
