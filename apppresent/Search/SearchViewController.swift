//
//  SearchViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 10/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Kingfisher
// record what it entered in the search bar and search for it in the first and second name of users


class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    //var usernamearray = [searchedUser]()
    //var userarray = [UserData]()
    var searchedUsers = [searchedUser] ()
    
    @IBOutlet weak var tableview: UITableView!
    static func create() -> SearchViewController {
        return UIStoryboard(name: "search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    
    
    var keyword = ""
    func getData() {
        
        var search = searchbar.text
        var ref = Database.database().reference(withPath: "users").child("firstname")
        ref.observe(DataEventType.value) { (snapshot) in
            
           self.searchedUsers = snapshot.children.map ({return searchedUser(snapshot: $0 as! DataSnapshot)})
            self.searchedUsers.filter({return
                $0.name.contains("s")
                
                self.tableview.reloadData()
            })
            
        }
       
  
        
      
        
        
        
        
        // get all users
        // create new struct for users
        // var users = [String]()
        //users.filter({ return $0.displayName.contains(keyword) })
     
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchedUsers.count
    }
  
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SearchTableViewCell
        cell?.username.text = searchedUsers[indexPath.row].name
        if let url = URL(string: searchedUsers[indexPath.row].imageurl) {
            do {
        let image = ImageResource(downloadURL: url, cacheKey: url.path)
                cell?.userprofileimage.kf.setImage(with: image)
                
            }
            catch {
                 print("imageURL was not able to be converted into data") //
            }
       
         
    
    
}
           return UITableViewCell()
    }
}
    
        
    
    


struct searchedUser {
    let name: String
    let imageurl : String
    
    
    init(name:String, imageurl:String) {
        self.name = name
        self.imageurl = imageurl
    }
    
    init (snapshot: DataSnapshot) {
        var snapshotvalue = snapshot.value as? NSDictionary
        
        if let names = snapshotvalue?["firstname"] as? String {
            name = names
        }
        else {
            name = ""
        }
        
        if let url = snapshotvalue?["url"] as? String {
            imageurl = url
        }
        else {
            imageurl = ""
        }
    }
    
}
