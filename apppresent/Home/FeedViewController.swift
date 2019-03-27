//
//  FeedViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 03/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import SDWebImage
import PKHUD

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var datasource = [PostData]()
    @IBOutlet weak var feedTableView: UITableView!
    // to append data from snapshot to array from firebase
    static func create() -> FeedViewController {
        return UIStoryboard(name: "home", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        feedTableView.dataSource = self as! UITableViewDataSource
        downloadPost()
        setupView()
        
    
        
    }
    
    
    func viewWillAppear() {
       // super.viewWillAppear()
        
        feedTableView.dataSource = self as! UITableViewDataSource
        downloadPost()
        setupView()
        
    }
    
    
    
    func setupView() {
        navigationController?.isNavigationBarHidden = true
        let headerView = makeHeaderView()
        feedTableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 182)
    }
    
    
    func downloadPost(){
        guard let myId = Auth.auth().currentUser?.uid else { return }
        if datasource.isEmpty {
            HUD.show(.progress, onView: view)
        }
        let postDB = Database.database().reference().child("posts").observe(.value) { (returnData) in
            guard let rawData = returnData.value as? [String: Any] else { return }
            let posts = Array(rawData.values).map({ return PostData(rawData: $0) })
            let followingDb = Database.database().reference()
                .child("following")
                .child(myId)
            followingDb.observe(.value, with: { (followersSnapshot) in
                guard let followersRawData = followersSnapshot.value as? [String: Any] else {
                    self.datasource = posts
                    self.feedTableView.reloadData()
                    return
                }
                let followers = Array(followersRawData.keys)
                
                let myFollowerPosts = posts.filter({ return followers.contains($0.userId ?? "") })
                self.datasource = myFollowerPosts.sorted(by: { return $0.timestamp < $1.timestamp })
                self.feedTableView.reloadData()
                
                let myPostsDB = Database.database().reference().child("users")
                
                myPostsDB
                .queryOrderedByKey().queryEqual(toValue: myId)
                .observe(.value, with: { [weak self] (snapshot: DataSnapshot) in
                
                var myPost = [PostData]()
                //let myPost = Array(followersRawData.keys)
                //myFollowerPosts.append(<#T##newElement: PostData##PostData#>)
                self?.feedTableView.reloadData()
                    
                HUD.hide(animated: true)
            })
        })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       print (datasource.count)
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "feedcell", for: indexPath) as? PostTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedcell") as! PostTableViewCell
        //cell.textLabel?.text = datasource[indexPath.row].caption
        let image = datasource[indexPath.row]
        print("THIS IS image url")
        //print (datasource)
        print (image.url)
        cell.feedimageview.sd_setImage(with: URL(string: image.url), placeholderImage: nil)
        
        //cell.feedimageview.sd_setImage(with: URL(string: image.url), placeholderImage: UIImage(named:"image1"))
        cell.feedcaptionlbl.text = image.caption ?? "No caption"
        
        
        
        
        if let name = datasource[indexPath.row].author {
            cell.feednamelbl.text = name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FeedViewController {
    
    func makeHeaderView() -> UIView {
        let circle = UIMaker.makeView(background: UIColor.c_102_100_247)
        let helloLabel = UIMaker.makeLabel(text: "Hello, let's share and Celebrate",
                                           font: UIFont.systemFont(ofSize: 17), color: .white)
        let headerView = UIView()
        let addButton = UIMaker.makeButton(title: "Add Post",
                                           titleColor: UIColor.c_102_100_247,
                                           font: UIFont.boldSystemFont(ofSize: 17),
                                           background: .white, cornerRadius: 5)
        headerView.addSubviews(views: circle, helloLabel, addButton)
        circle.centerX(toView: headerView)
        circle.bottom(toView: headerView)
        let edge: CGFloat = 800
        circle.square(edge: edge)
        circle.setCorner(radius: edge / 2)
        
        helloLabel.centerX(toView: headerView)
        helloLabel.top(toView: headerView, space: padding / 2)
        
        addButton.backgroundColor = .white
        addButton.setCorner(radius: 7)
        addButton.size(CGSize(width: 200, height: 44))
        addButton.centerX(toView: headerView)
        addButton.verticalSpacing(toView: helloLabel, space: padding)
       
        addButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
        
        
        headerView.height(150)
        return headerView
    }
    
    @objc func createPost() {
         let controller = UploadPostViewController.create()
        
        
        controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController?.present(controller, animated: true, completion: nil)
        //self.present(alertVC, animated: true, completion: nil)
       //controller.modalPresentationStyle = .p
        //self.navigationController?.popoverPresentationController(controller)
        //self.navigationController?.pushViewController(controller, animated: true)
    }
}
