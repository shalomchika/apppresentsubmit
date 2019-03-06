//
//  UIImageExtension.swift
//  apppresent
//
//  Created by Macbook Pro on 16/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//
import UIKit
import Foundation
import Kingfisher

extension UIView {
    func setRounded(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}


extension UIImageView {
    func downloadImage(from url: String?, placeholder: UIImage? = nil) {
        guard let url = url, let nsurl = URL(string: url) else { return }
        kf.setImage(with: ImageResource(downloadURL: nsurl), placeholder: placeholder)
    }
}
