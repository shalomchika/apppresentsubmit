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
        var dataname = datasource[indexPath.row].fullname
        cell.username.text = dataname!
        cell.userprofileimage.downloadImage(from: datasource[indexPath.row].profileimageurl , placeholder: UIImage(named: "user_placeholder"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! SearchTableViewCell
        let profileController = ProfilePageViewController.create()
        profileController.currentuserdata = datasource[indexPath.row]
        profileController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(profileController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
