//
//  PostTableViewCell.swift
//  apppresent
//
//  Created by Macbook Pro on 21/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import PKHUD
import SDWebImage

class PostTableViewCell: UITableViewCell {
    private var data: PostData?
    private var author: UserData?
    
    func setData(_ data: PostData) {
        self.data = data
        feedimageview.downloadImage(from: data.url, placeholder: nil)
        //feedimageview.sd_setImage(with: URL(string: data.url), placeholderImage: nil)
        feedcaptionlbl.text = data.caption
        
        getAuthor()
    }
    
    func getAuthor() {
        guard let authId = data?.userId else { return }
        DatabaseNode.getDb(.users)
            .child(authId)
            .observeSingleEvent(of: .value) { (snapshots) in
                guard let rawData = snapshots.value as? [String: AnyObject] else { return }
                let user = UserData(rawData: rawData)
                self.author = user
                
                // change rawData["firstname"] as? String ?? "" -> user.firstname
                let firstName = rawData["firstname"] as? String ?? ""
                let lastName = rawData["lastname"] as? String ?? ""
                let fullName = "\(firstName) \(lastName)"
                self.feednamelbl.text = fullName
                let url = rawData["profileImageUrl"] as? String ?? ""
                self.avatarImageView.downloadImage(from: url, placeholder: UIImage(named: "user_placeholder"))
        }
    }
    
    
    @IBOutlet weak var feedimageview: UIImageView!
    @IBOutlet weak var feedcaptionlbl: UILabel!
    @IBOutlet weak var feednamelbl: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImageView.setCorner(radius: 20)
        avatarImageView.image = UIImage(named: "user_placeholder")
        feedimageview.contentMode = .scaleAspectFill
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.feedimageview.image = nil
        self.feedcaptionlbl.text = ""
        feednamelbl.text = ""
        //avatarImageView.image = nil
        
        // this is demo for git stash 
    }
    
    
    @IBAction func goToProfile(_ sender: Any) {
        let controller = ProfilePageViewController.create()
        controller.currentuserdata = author
        UIApplication.topViewController()?.navigationController?.pushViewController(controller, animated: true)
   
    }
    
}
