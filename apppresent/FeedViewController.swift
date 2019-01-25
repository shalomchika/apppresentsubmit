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
        view.backgroundColor = .green
        feedTableView.dataSource = self as! UITableViewDataSource
        downloadPost()
        //loadPosts()
    
     

  
        
    }
    
    
    
    func downloadPost() {
        
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
    
    
    func loadPosts() { // detect any event, observe child added and get it for is from all data from database and get associated data.
        //grabs each post one by one and puts it into a dictionary and each post is grabbed an encapsulated into its own dictionary
        
        // post retrieved one by one and added to an optional dictionary
        
        //https://www.youtube.com/watch?v=zsFnRvdu96I&t=60s
        
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot: DataSnapshot) in
             print("POSTS!!")
            //print(snapshot.value)
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
                self.datasource = snapshot.children.map({ return PostData(snapshot: $0 as! DataSnapshot) })
                
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
       
        cell.backgroundColor = UIColor.red
        //cell.textLabel?.text = datasource[indexPath.row].caption
        let image = datasource[indexPath.row]
        print("THIS IS image url")
        //print (datasource)
        print (image.url)
        cell.feedimageview.sd_setImage(with: URL(string: image.url), placeholderImage: UIImage(named:"image1"))
        cell.feedcaptionlbl.text = image.caption ?? "No caption"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 400 -> square on iphone 8+/7+/6+ -> because its width is equal 400
        // 400 -> rectangle on iphone SE -> because its width is equal 200
        return 400
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

