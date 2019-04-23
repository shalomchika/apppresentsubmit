//
// Extension.swift
// apppresent
//
// Created by Macbook Pro on 23/03/2019.
// Copyright © 2019 Macbook Pro. All rights reserved.
//

//https://github.com/nguyentruongky/knstore

import UIKit

var screenWidth: CGFloat { return UIScreen.main.bounds.width }
var screenHeight: CGFloat { return UIScreen.main.bounds.height }
let appDelegate = UIApplication.shared.delegate as! AppDelegate
var statusBarStyle = UIStatusBarStyle.lightContent
var isStatusBarHidden = false

class knController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func setupView() { }
    func fetchData() { }
    deinit {
        print("Deinit \(NSStringFromClass(type(of: self)))")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return statusBarStyle }
    override var prefersStatusBarHidden: Bool { return isStatusBarHidden }
}
// do you

class knCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    func setupView() { }
}

class knTableCell : UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        selectionStyle = .none
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    func setupView() { }
    static func wrap(view: UIView, space: UIEdgeInsets = .zero) -> knTableCell {
        let cell = knTableCell()
        cell.backgroundColor = .clear
        cell.addSubviews(views: view)
        view.fill(toView: cell, space: space)
        return cell
    }
    
}// could I get  link for your code to state its yours is it from an online blog or something I can quote.
//which one is it
//as soon as you can
//also the rest is constraint stuff. Constraint for upload images and for the gift page need to add a title. Thats mainly it.
// will do keyboard later tonight.

extension String {
    static func format(strings: [String],
                       boldFont: UIFont = UIFont.boldSystemFont(ofSize: 14),
                       boldColor: UIColor = UIColor.blue,
                       inString string: String,
                       font: UIFont = UIFont.systemFont(ofSize: 14),
                       color: UIColor = UIColor.black,
                       lineSpacing: CGFloat = 7,
                       alignment: NSTextAlignment = .left) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.maximumLineHeight = 40
        paragraphStyle.alignment = alignment
        
        let attributedString =
            NSMutableAttributedString(string: string,
                                      attributes: [
                                        NSAttributedString.Key.font: font,
                                        NSAttributedString.Key.foregroundColor: color,
                                        NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let boldFontAttribute = [NSAttributedString.Key.font: boldFont,
                                 NSAttributedString.Key.foregroundColor: boldColor]
        for bold in strings {
            attributedString.addAttributes(boldFontAttribute, range: (string as NSString).range(of: bold))
        }
        return attributedString
    }
}
