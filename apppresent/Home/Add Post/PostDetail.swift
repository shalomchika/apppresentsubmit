//
//  PostDetail.swift
//  apppresent
//
//  Created by Macbook Pro on 09/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import Kingfisher

class PostDetail: UIViewController {
    static func create() -> PostDetail {
        return create(fromStoryboard: "profile")
    }
    
    var data: PostData?
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func setData() {
        guard let urlString = data?.url,
            let url = URL(string: urlString) else { return }
        let resource = ImageResource(downloadURL: url)
        postImageView.kf.setImage(with: resource)
        captionLabel.text = data?.caption
    }
}



