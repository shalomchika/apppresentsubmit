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
} //the gif?

// is it possible to reference it ? or no? just need the link to the github
extension UIImageView {
    func downloadImage(from url: String?, placeholder: UIImage? = nil) {
        if placeholder == nil {
            image = UIImage(named: "imagePlaceholder")
        }
        guard let url = url, let nsurl = URL(string: url) else { return }
        kf.setImage(with: ImageResource(downloadURL: nsurl), placeholder: placeholder)
    }
    
    func changeColor(to color: UIColor) {
        guard let image = image else { return }
        self.image = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tintColor = color
    }
}

