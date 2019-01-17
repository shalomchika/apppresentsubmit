//
//  FeedViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 03/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    static func create() -> FeedViewController {
        return UIStoryboard(name: "home", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
