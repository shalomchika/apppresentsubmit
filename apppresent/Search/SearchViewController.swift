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

class NameArray {
    var userarray = [UserData]()
}

class SearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate{
    
   
    @IBOutlet weak var searchbar: UISearchBar!
    

    //var userarray = [UserData]()
    var userarray = NameArray().userarray
    
    var datasource = [UserData] ()
    //var usernamearray = [searchedUser]()
    //var userarray = [UserData]()

    
    @IBOutlet weak var tableview: UITableView!
    static func create() -> SearchViewController {
        return UIStoryboard(name: "profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! SearchViewController
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        //self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
         self.tableview.allowsSelection = true
        guard let myId = Auth.auth().currentUser?.uid else { return }
        let userDB = Database.database().reference().child("users").observe(.value) { (returnData) in
            guard let rawData = returnData.value as? [String: Any] else { return }
            self.userarray = Array(rawData.values).map({ return UserData(rawData: $0) })
        }
        self.tableview.delegate  = self
        //self.tableview.datasource  = self
            
            
        }
        //create a usersearchobject of user search type and append it to to
        //getData()
        
        // Do any additional setup after loading the view.


    
    //change the content depending on what I put in the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        
        guard !searchText.isEmpty else { return}
       
     var resultarray = [UserData]()

        for user in userarray {
            if user.fullname.contains(searchText)  {
                 resultarray.append(user)
            }
           
        }
        // in the firebase I have the timestamp with the id
       // self.datasource = datasource.(by: { return $0.timestamp > $1.timestamp })
        
       // self.datasource.filter({return $0.name.contains(searchText)
        self.datasource = resultarray
        self.tableview.reloadData()
            
        
        
    }
    

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        hideKeyboard()
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    
/*
    
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
    */

     
    
    

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
       let cell = tableView.dequeueReusableCell(withIdentifier: "searchcell") as! SearchTableViewCell
        
        // fetch an example optional string
        //let optionalString = datasource[indexPath.row].fullname?.description
        
        // now unwrap it
        
        var dataname = datasource[indexPath.row].fullname
        cell.username.text = dataname!
        
        if let url = URL(string: datasource[indexPath.row].profileimageurl) {
            do {
                
        let image = ImageResource(downloadURL: url, cacheKey: url.path)
                cell.userprofileimage.kf.setImage(with: image)
                
            }
            catch {
                 print("imageURL was not able to be converted into data") //
            }
       
         
    
    
}
           return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        //get from row to their page
        //tableview.deselectRow(at: indexPath, animated: true)
        let currentCell = tableView.cellForRow(at: indexPath) as! SearchTableViewCell
        
        print(currentCell.textLabel!.text)
        var searchedname  = currentCell.username.text
        
        /*
        var ref  = Database.database().reference()
        var searcheduserdata = UserData?.self
        var data = [UserData]()
        var userrawdata = [UserData]()
        ref.child("users")
            .queryOrdered(byChild: "fullname")
            .queryEqual(toValue: searchedname)
            .observeSingleEvent(of: .value, with: { (snapshot) -> Void in
                
                print(snapshot)
                var snapshotvalue = snapshot.value as? NSDictionary
                snapshotvalue = snapshotvalue?.allValues.first as? NSDictionary
                //convert to raw data
                var searchedusersid = snapshotvalue?["userID"] as? String
                 guard let rawData = snapshotvalue as? [String: Any] else { return  }
               
                
                userrawdata = [UserData(rawData: rawData)]
                // send to user data object
                
              
                //data  = rawData.values.map({ return UserData(rawData: $0) })
                
                
                
            
                //use the whole shapshot value
                //pass to profile page
                //user data
                
                print(snapshot)
                
            }
         
        
        )
        */
        
        //get from row to their page
        //tableview.deselectRowat: indexPath, animated: true)
        
        
        // you get all users -> you have all UserData
        // select one you want to view detail
        // get the speciafic one from all usrs (already downloaded)
        // send selected one to profile page
        
        let profileController = ProfilePageViewController.create()
        profileController.currentuserdata = datasource[indexPath.row]
      profileController.hidesBottomBarWhenPushed = true
        // navigationController (has tab bar shown)
        // hidesBottomBarWhenPushed -> push -> hiden tab bar in the destiantion  contrller 
        
        // pass the snapshot to profile page as user data object
        self.navigationController?.pushViewController(profileController, animated: true)
        //let storyboard = UIStoryboard(name: "profile", bundle: nil)
        //let destinationNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController") as! UINavigationController
        //destinationNavigationController.pushViewController(controller, animated: true)
        //self.navigationController?.pushViewController(controller, animated: true)
 
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //table view delegate
    // if you select the searched user displays the user profile page with hidden button




    
/*

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

    
 
    init(rawData: Any) {
        guard let data = rawData as? [String: Any] else { return }
       
        imageurl = data["url"] as? String
        name = data["firstname"] as? String
       
    }
 
    
}

*/
}
