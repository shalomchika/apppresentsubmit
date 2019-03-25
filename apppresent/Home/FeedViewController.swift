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


    

    
   
    var datasource = [PostData] ()

   // @IBOutlet weak var feedimageviewview: UIImageView!
    
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
    
    
    
    func downloadPost1() {
        
        let poststorage = Storage.storage().reference(withPath: "posts")
        let postdatabase = Database.database().reference(withPath: "posts")
        let currentuser = Auth.auth().currentUser
        
        /*
         var userquery =  postdatabase.queryEqual(toValue: currentuser, childKey: "userID")
         
         // grab post for current user
         //grab pathToImage from them
         //get download url and pass to cell for Item At
         print(userquery)
         postdatabase.observe(DataEventType.value) { (snapshot) in
         
         for postdatasnapshot in snapshot.children {
         
         let postdataobject = PostData (snapshot: postdatasnapshot as! DataSnapshot)
         
         
         
         }
         
         // find the user with user id of the current user
         //get the download url
         //feed it to cellforItemAt
         
         }
         
         */
        // need to make BRug etc.... a string from current user variable , its just a test value
        
        var newuserposts = [PostData]() //1
        postdatabase
            .queryOrdered(byChild: "userID").queryEqual(toValue: "BRugt1SWc3Ruxq5kyh8M3RG74Dg1") // 2
            .observe(.value, with: { (snapshot: DataSnapshot) in
                // 3
                
                for userpostsnapshot in snapshot.children {
                    let userpostobject = PostData(snapshot: userpostsnapshot as! DataSnapshot )
                    newuserposts.append(userpostobject)
                }
                // 4
                self.datasource = newuserposts
                self.feedTableView.reloadData()
            })
        
        
        // is this project is your school assignment? yeah and I will use it after for my personal project which has similar features
        //suggest: add project to github => add me into your git hub
        // I do: break tasks for you
        // you do: pick tasks and finish in order /Users/macbookpro/development/apppresent/apppresent/profile.storyboard:-1: Encountered an error communicating with IBAgent-iOS.asap
        // you do: get back to get new tasks
        // i want to develop apps after
        
    }
    
    func downloadPost(){
        guard let myId = Auth.auth().currentUser?.uid else { return }
        if datasource.isEmpty {
            HUD.show(.progress, onView: view)
        }
        let postDB = Database.database().reference().child("posts").observe(.value) { (returnData) in
            guard let rawData = returnData.value as? [String: Any] else { return }
            // rawData has many items
            // -> get all rawData values -> all vaues -> isnot Array -> have to parse to array
            let posts = Array(rawData.values).map({ return PostData(rawData: $0) })
            // rawData.values is Any
            // PostData
            // posts: [PostData]
            // map Array(Any) -> Array(PostData)
            // ok
            
            // map is similar to for loop
            // for item in array {
            //create new PostData by pass item into
            //}
            
            // now we hvae all posts form everyone
            // we hvae to filter posts from my followers
            
            
            // todo
            // - add foloowers and test this function
            
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
                
                // I'll do it later but if they aren't following anyone I dont want it to throw an error. It will show something like when you sign up to instagram . I haven't figured out what. Or maybe an empty screen because its meant to be people you know for their birthdays. Ill put a default view there.
                // followrs : [1, 3, 7, 8]
                // post owner is 6
                
                // we have list of my followers
                // run a for loop to check if the owner of the post is my followers or not
                /*
                for item in posts {
                    if followers.contains(item.userId) {
                        // this post is form your follower
                        // add this post to an array
                    }
                }
                 */
                //its a high order function ( Ill read it up)
                
                // map, compactMap, reduce, filter ohhhhh
                // use
                // map: use to change an array of data type T to an array of data type Y
                // map: convert [Int} -> [String]
                // filter - check condition, if it meets return the item for me (the post item)
                // add it to array and display it?
                // any books you reccommend for after
                
                // add more users
                // add mroe posts from different users.
            // carry one sorry
                let myFollowerPosts = posts.filter({ return followers.contains($0.userId ?? "") })
                self.datasource = myFollowerPosts.sorted(by: { return $0.timestamp < $1.timestamp })
                self.feedTableView.reloadData()
                HUD.hide(animated: true)
            })
            
        }
    }
    
    
    func loadPosts1() { // detect any event, observe child added and get it for is from all data from database and get associated data.
        //grabs each post one by one and puts it into a dictionary and each post is grabbed an encapsulated into its own dictionary
        
        // post retrieved one by one and added to an optional dictionary
        
        //https://www.youtube.com/watch?v=zsFnRvdu96I&t=60s
        
      
        

        
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot: DataSnapshot) in
             print("POSTS!!")
            //print(snapshot.value)
            // you want to get post from followers only
            //yeah Im not sure this function gets used as I think ....
            
            
            // get all posts
            // get all followers
            // filter posts from followers
            
            
            https://www.youtube.com/watch?v=Aw5Hb_A_eFI
                //coudl be anything type of value form Post data so cast to any type with if let
                //unwrap data and show in dictionart
                if let dict = snapshot.value as? [String: Any] {
                let feedcaption = dict["caption"] as? String
                let feedurl = dict["pathToImage"] as? String
                //let feedkey = dict["key"] as? String
                //let post = PostData(url: feedurl ?? "no url", key: feedurl ?? "no key" , caption: feedcaption ?? "no caption")
                //self.posts.append(post)
               // print(self.posts)
                //self.downloadPost()
                if let url = URL(string: feedurl ?? "") {
                    do {
                        let imageAsData = try Data(contentsOf: url)
                        let image = UIImage(data: imageAsData)
                       // self.feedimageview.image = image
                    } catch {
                        print("imageURL was not able to be converted into data") // Assert or add an alert
                    }
                    
                }
                print(snapshot)
                
                var postref = Database.database().reference(withPath: "posts")
                postref.observe(DataEventType.value) { (snapshot) in
                    self.datasource = snapshot.children.map({ return PostData(snapshot: $0 as! DataSnapshot) })
                
         
            /* UP TILL HERE  was in view did load*/
            
            
            // connect to firebase database
            var postref = Database.database().reference(withPath: "posts")
            postref.observe(DataEventType.value) { (snapshot) in
                guard let rawData = snapshot.value as? [AnyObject] else { return }
                let posts = rawData.map({ return PostData(rawData: $0) })
                print(posts)
                //self.datasource = snapshot.children.sorted(by: { return $0.timestamp > $1.timestamp })
     

                //self.collectionview.reloadData()
                
                //self.datasource = snapshot.children.map({ return PostData(snapshot: $0 as! DataSnapshot) })
                
                // save to firebase
                //collection is a iterator from first to last element type
                //map is a high order function used on collection types
                //0$ is the data
                
                
                // var newposts = [PostData].self
                //self.collectionview.reloadData()
                
            }
            
                self.feedTableView.reloadData()
                //put everything in the array
                
                print(dict)
            }
            //print all snapshots
        }
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
/*
extension FeedViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedcell", for: indexPath) as! PostTableViewCell
 
        cell.backgroundColor = UIColor.red
       // cell.textLabel?.text = datasource[indexPath.row].caption
        let image = datasource[indexPath.row]
 
    cell.feedimageview.sd_setImage(with: URL(string: image.url), placeholderImage: UIImage(named:"image1"))
        
        return cell
    }

}

}

extension FeedViewController : UITableViewDelegate {
 
    
}


*/

// I will fix this in my side. Next issue


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
