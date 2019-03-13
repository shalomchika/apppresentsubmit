//
//  GlobalSupporter.swift
//  Fixir
//
//  Created by Ky Nguyen on 3/9/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

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
    
}
