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
        if placeholder == nil {
            image = UIImage(named: "imagePlaceholder")
        }
        guard let url = url, let nsurl = URL(string: url) else { return }
        image = placeholder
        kf.setImage(with: ImageResource(downloadURL: nsurl), placeholder: placeholder) { [weak self] (value) in
            if let _ = value.error {
                self?.image = placeholder
            } else {
                self?.image = value.value?.image
            }
        }
        kf.setImage(with: ImageResource(downloadURL: nsurl), placeholder: placeholder)
    }
    
    func changeColor(to color: UIColor) {
        guard let image = image else { return }
        self.image = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tintColor = color
    }
}

