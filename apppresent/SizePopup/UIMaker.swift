//
//  UIMaker.swift
//  knCollection
//
//  Created by Macbook Pro on 01/01/2019.
//

import UIKit

class UIMaker {
    
    static func makeLabel(text: String? = nil,
                          font: UIFont = .systemFont(ofSize: 15),
                          color: UIColor = .black,
                          numberOfLines: Int = 1,
                          alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.textColor = color
        label.text = text
        label.numberOfLines = numberOfLines
        label.textAlignment = alignment
        return label
    }
    
    static func makeView(background: UIColor? = .clear) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = background
        return view
    }
    
    static func makeImageView(image: UIImage? = nil,
                              contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImageView {
        let iv = UIImageView(image: image)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = contentMode
        iv.clipsToBounds = true
        return iv
    }

    static func makeButton(title: String? = nil,
                           titleColor: UIColor = .black,
                           font: UIFont? = nil,
                           background: UIColor = .clear,
                           cornerRadius: CGFloat = 0,
                           borderWidth: CGFloat = 0,
                           borderColor: UIColor = .clear) -> UIButton {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)

        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor.withAlphaComponent(0.4), for: .disabled)
        
        button.titleLabel?.font = font
        button.createRoundCorner(cornerRadius)
        button.createBorder(borderWidth, color: borderColor)
        return button
    }
    
    static func makeTextfield(title: String? = nil,
                           titleColor: UIColor = .black,
                           font: UIFont? = nil,
                           background: UIColor = .clear,
                           cornerRadius: CGFloat = 0,
                           borderWidth: CGFloat = 0,
                           borderColor: UIColor = .clear) -> UITextField {
        var textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
       // textfield.setTitle(title, for: .normal)
        textfield.text = "Enter size"
        // textfield.setTitle(title, for: .normal)
        textfield.textColor = UIColor.black
        textfield.textColor?.withAlphaComponent(0.4)
        //textfield.setTitleColor(titleColor.withAlphaComponent(0.4), for: .disabled)
        
       // textfield.titleLabel?.font = font
         textfield.font = font
        textfield.createRoundCorner(cornerRadius)
        textfield.createBorder(borderWidth, color: borderColor)
        return textfield
    }
    
    
}

