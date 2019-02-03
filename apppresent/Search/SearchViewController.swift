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
import FirebaseStorage
// record what it entered in the search bar and search for it in the first and second name of users


class SearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate{
    
    @IBOutlet weak var searchbar: UISearchBar!
        var datasource = [searchedUser] ()
    //var usernamearray = [searchedUser]()
    //var userarray = [UserData]()
    
    
    @IBOutlet weak var tableview: UITableView!
    static func create() -> SearchViewController {
        return UIStoryboard(name: "search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        // Do any additional setup after loading the view.
    }
    
    //change the content depending on what I put in the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        
        guard !searchText.isEmpty else { return}
        // var search = searchbar.text
        /*
        var ref = Database.database().reference(withPath: "users").child("firstname")
        ref.observe(DataEventType.value) { (snapshot) in
            
            self.searchedUsers = snapshot.children.map ({return searchedUser(snapshot: $0 as! DataSnapshot)})
 */
        

            self.datasource.filter({return
                $0.name.contains(searchText)
                
                self.tableview.reloadData()
            })
            
        }

        
    

    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    
    var keyword = ""
    
    func getData() {
        // initialise each user(title and image) object
        // append to an array
        // filter the display
       // var search = searchbar.text
        //create an array of searched user type
        var searchobjects = [searchedUser]()
        var userref = Database.database().reference(withPath: "users")
        // retrieve all users
        userref.observe(DataEventType.value) { (snapshot) in
          // exists here
            //for every snapshot convert to that instance
            for usersnapshot in snapshot.children {
                
                let objects = searchedUser(snapshot: usersnapshot as! DataSnapshot)
                
                searchobjects.append(objects)

            }
       
            self.datasource = searchobjects
            self.tableview.reloadData()
            
                
            }
            //create a usersearchobject of user search type and append it to to
           
            //self.dataso
            
           // self.searchedUsers.filter({return $0.name.contains("s")
                
              //  self.tableview.reloadData()
         //   })
            
        }
    
  


      
        
        
        
        
        // get all users
        // create new struct for users
        // var users = [String]()
        //users.filter({ return $0.displayName.contains(keyword) })
     
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datasource.count
    }
  
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "searchcell") as? SearchTableViewCell
        cell?.username.text = datasource[indexPath.row].name
        if let url = URL(string: datasource[indexPath.row].imageurl) {
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
    var name: String!
    var imageurl : String!
    var key: String!
    var itemRef : DatabaseReference?
    
    init(name:String, imageurl:String, key : String) {
        self.name = name
        self.imageurl = imageurl
        self.key  = key
        self.itemRef = nil
    }
    
    init (snapshot: DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        
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
    
    var firstname: String?
    var url: String?
    init(rawData: Any) {
        guard let data = rawData as? [String: Any] else { return }
        firstname = data["firstname"] as? String
        url = data["url"] as? String
       
    }

    
    /*
    init(rawData: Any) {
        guard let data = rawData as? [String: Any] else { return }
       
        imageurl = data["url"] as? String
        name = data["firstname"] as? String
       
    }
 */
    
}

