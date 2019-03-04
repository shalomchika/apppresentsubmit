//
//  UserPostDetail.swift
//  apppresent
//
//  Created by Macbook Pro on 18/02/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit

class UserPostDetail: UIViewController {
    
    let newImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var captionlbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(newImageView)
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
