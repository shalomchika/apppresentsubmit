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
        feedTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        Database.database().reference().child("posts").observe(.value) { (returnData) in
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
                var followers = Array(followersRawData.keys) // -> a list of followers
                followers.append(myId)
                
                let myFollowerPosts = posts.filter({ return followers.contains($0.userId ?? "") })
                self.datasource = myFollowerPosts.sorted(by: { return $0.timestamp > $1.timestamp })
                self.feedTableView.reloadData()
                HUD.hide(animated: true)
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       print (datasource.count)
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedcell") as! PostTableViewCell
        let data = datasource[indexPath.row]
        cell.setData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}// I think I will have to set the image to a particular size in the crop editor and let them zoo etc with a library


extension FeedViewController {
    
    func makeHeaderView() -> UIView {
        let circle = UIMaker.makeView(background: UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1))
        let helloLabel = UIMaker.makeLabel(text: "Hello, let's share and Celebrate",
                                           font: UIFont.systemFont(ofSize: 17), color: .white)
        let headerView = UIView()
        let addButton = UIMaker.makeButton(title: "Add Post",
                                           titleColor: UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
                                            ,
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
