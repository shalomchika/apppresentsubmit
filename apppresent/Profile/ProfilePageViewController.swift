//
//  ProfilePageViewController.swift
//  apppresent
//
//  Created by Macbook Pro on 01/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SDWebImage
import Kingfisher

class ProfilePageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    static func create() -> ProfilePageViewController {
        return UIStoryboard(name: "profile", bundle: nil).instantiateViewController(withIdentifier: "ProfilePageViewController") as! ProfilePageViewController
    }
    
    
    var currentUser: UserData?
  
    
    @IBOutlet weak var loadview: UIView!
    
    var activityindicator: UIActivityIndicatorView = UIActivityIndicatorView()
    

    var image: UIImage!
    
    var datasource = [PostData]() //data structure defined
    //collection = imagecollection
    //collectionViewCell = imageCollectionViewCell
     var ref = Database.database().reference()
   // let userid = Auth.auth().currentUser!.uid
    
    @IBOutlet weak var collectionview: UICollectionView!
    var customimageflowlayout : CustomImageFlowLayout!
    @IBOutlet weak var profileimageview: UIImageView!
    @IBOutlet weak var displaystatuslbl: UILabel!
    @IBOutlet weak var displaynamelbl: UILabel!
   
    @IBAction func editProfile(_ sender: Any) {
        let controller = EditProfileViewController.create()
        controller.profilePage = self
        navigationController?.pushViewController(controller, animated: true)
    }
    @IBOutlet weak var displayagelbl: UILabel!
    var age = 0
    var stringage = ""
    var birthday = ""
    var status = ""
    var profileImageUrl = ""
    var firstname = ""
    var lastname = ""
    var fullname = ""
    var  selectedimage : UIImage?
   
    
    /*
    override func viewDidLoad() {
        //https:www.youtube.com/watch?v=4lssReDhpWU for layout from 10:00 ish
       
        super.viewDidLoad()
        /*
        customimageflowlayout = CustomImageFlowLayout()
        collectionview.collectionViewLayout = customimageflowlayout
        collectionview.backgroundColor = .white
        displaynamelbl.preferredMaxLayoutWidth = 150
        displayagelbl.preferredMaxLayoutWidth = 150
        displaystatuslbl.preferredMaxLayoutWidth = 150
        profileimageview.layer.cornerRadius = 40
        profileimageview.clipsToBounds = true
      
        let userid = Auth.auth().currentUser?.uid
           ref.child("users").child(userid ?? "").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
           
            let firstname = value?["firstname"] as? String ?? ""
            let lastname = value?["lastname"] as? String ?? ""
            let age = value?["age"] as? Int ?? 0
            let status = value?["status"] as? String ?? ""
            let fullname = "\(firstname) \(lastname)"
            let imageurl = value?["profileImageUrl"] as? String ?? ""
            print("This is age" ,age)
            let stringage = String(age)
            print(stringage)
            print(imageurl)
            print("This is status ", status)
            print(" This is fullname " ,fullname)
            
            self.displaystatuslbl?.text = status
            self.displayagelbl?.text = stringage
            self.displaynamelbl?.text = fullname
            
            if let url = URL(string: imageurl) {
                do {
                    let imageAsData = try Data(contentsOf: url)
                    let image = UIImage(data: imageAsData)
                    self.profileimageview.image = image
                } catch {
                    print("imageURL was not able to be converted into data") // Assert or add an alert
                }
   
                }
               print(snapshot)
    
            
        })
        
      
        
        
   
        let hello = "hello"
        self.displayagelbl?.text = hello
       
       // self.displaynamelbl.text = fullname
 
 */
    }
 */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        let remindButton = UIBarButtonItem(title: "Remind me", style: .done, target: self, action: #selector(addReminder))
        navigationController?.navigationItem.rightBarButtonItem = remindButton
    }
    
    
  
    //everytime you go to screen it will load data again, waste of time to reload.
   // sorry also the profiel picture not staying the edit page. I cna look at it again. if you want to move on.
    func getData() {
        startloading()
        loadDB()
        stoploading()
    }
    override func viewWillAppear(_ animated: Bool) {
      
        super.viewWillAppear(animated)
        
        //startloading()
        // load db again
      
    }
   /*
    @IBAction func editbtn(_ sender: Any) {
        
      EditProfileViewController.create()
        window!.rootViewController = AppTabViewController.create()
    }
 
 */
    
    func loadDB() {
        
        customimageflowlayout = CustomImageFlowLayout()
        collectionview.collectionViewLayout = customimageflowlayout
        collectionview.backgroundColor = .white
        
        
        displaynamelbl.preferredMaxLayoutWidth = 150
        displayagelbl.preferredMaxLayoutWidth = 150
        displaystatuslbl.preferredMaxLayoutWidth = 150
        profileimageview.layer.cornerRadius = 40
        profileimageview.clipsToBounds = true
        //self.profileimageview.image = selectedimage
        
        //works
        //var hello = "hello"
        // self.displayagelbl?.text = hello
        //  let ref = Database.database().reference()
        // Do any additional setup after /loading the view.
        var searcheduser : String?
        
        var searcheduserid: String?
        
        let userid = Auth.auth().currentUser?.uid
        ref.child("users").child(userid ?? "").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let firstname = value?["firstname"] as? String ?? ""
            let lastname = value?["lastname"] as? String ?? ""
            let age = value?["age"] as? Int ?? 0
            let status = value?["status"] as? String ?? ""
            let fullname = "\(firstname) \(lastname)"
            let imageurl = value?["profileImageUrl"] as? String ?? ""
            print("This is age" ,age)
            let stringage = String(age)
            print(stringage)
            print(imageurl)
            print("This is status ", status)
            print(" This is fullname " ,fullname)
            
            self.currentUser = UserData(snapshot: snapshot)
            
            self.displaystatuslbl?.text = status
            self.displayagelbl?.text = stringage
            self.displaynamelbl?.text = fullname
            
            if let url = URL(string: imageurl) {
                do {
                    
                    
                    let resource = ImageResource(downloadURL: url, cacheKey: url.path)
                    self.profileimageview.kf.setImage(with: resource)
                    
                    /*
                    let imageAsData = try Data(contentsOf: url)
                    let thisimage = UIImage(data: imageAsData)
                    self.image = thisimage
                    //self.profileimageview.image = thisimage
                   */
                } catch {
                    print("imageURL was not able to be converted into data") // Assert or add an alert
                }
                
            }
            print(snapshot)
 
            
        })
        
         //self.profileimageview.image = image
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
        
        downloadPost()
        
        
    }

    func startloading () {
        
        self.view.addSubview(activityindicator)
            activityindicator.center = self.view.center
        activityindicator.hidesWhenStopped = true
        activityindicator.style = UIActivityIndicatorView.Style.gray
        activityindicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stoploading() {
        activityindicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func collectionView(_ collection: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }

    @IBAction func addReminder(_ sender: Any) {
        let controller = ReminderViewController.create()
        controller.user = currentUser
        //controller. = self
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func downloadPost() {
        
        let poststorage = Storage.storage().reference(withPath: "posts")
        let postdatabase = Database.database().reference(withPath: "posts")
        let currentuser = Auth.auth().currentUser
        print(currentuser?.uid)
        
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

        /*
        postdatabase
            .queryOrdered(byChild: "userID").queryEqual(toValue: "BRugt1SWc3Ruxq5kyh8M3RG74Dg1") // 2
            .observe(.value, with: { (snapshot: DataSnapshot) in
 */
         var newuserposts = [PostData]() //1
        postdatabase
         .queryOrdered(byChild: "userID").queryEqual(toValue: currentuser?.uid) // 2
            .observe(.value, with: { (snapshot: DataSnapshot) in
    // 3
        
            for userpostsnapshot in snapshot.children {
                let userpostobject = PostData(snapshot: userpostsnapshot as! DataSnapshot )
                newuserposts.append(userpostobject)
            }
            // in the firebase I have the timestamp with the id
                self.datasource = newuserposts.sorted(by: { return $0.timestamp > $1.timestamp })
                self.collectionview.reloadData()
        })
        
        
        // is this project is your school assignment? yeah and I will use it after for my personal project which has similar features
        //suggest: add project to github => add me into your git hub
        // I do: break tasks for you
        // you do: pick tasks and finish in order /Users/macbookpro/development/apppresent/apppresent/profile.storyboard:-1: Encountered an error communicating with IBAgent-iOS.asap
        // you do: get back to get new tasks
        // i want to develop apps after
        
    }
    
// click on the image and see it in full view with a caption like instagram.
//the general feed with the people I follow
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = UIStoryboard(name: "profile", bundle: nil).instantiateViewController(withIdentifier: "PostDetail") as! PostDetail
        let data = datasource[indexPath.row]
        controller.newImageView.sd_setImage(with: URL(string: data.url), placeholderImage: UIImage(named:"image1"))
        
        //controller.captionlbl.text =
        
        //controller.captionlbl.text = data.
        navigationController?.pushViewController(controller, animated: true)
    }
    
      func collectionView(_ collection: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        //what it will show  image in collection loads
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
    //reference cell
        //find right image in array
        
        let image = datasource[indexPath.row]
        
        //what is the type of cell
        //loop through every child node and grab - pathToImage
        print("is the url here too?")
        print(image.url)
            cell.imageview.sd_setImage(with: URL(string: image.url), placeholderImage: UIImage(named:"image1"))
        
     return cell
    }
    
    
}
// if I do the post to feed view controller here , every individuals post will go there automatically, so thats the feed done?




// check if user logged in
//www.youtube.com/watch?v=qD582zfXlgo
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */



//...
// array
// map => convert an array (String) => another array (Int)
//
// compactMap => convert an array (String) => another array (Int) without nil items


//var newposts = [postData] ()

// information post we want
/*
 for postdatasnapshot in snapshot.children {
 let postdataobject = postData(snapshot: postdatasnapshot as! DataSnapshot)
 //populate view snapshot of databse that is images
 
 newposts.append(postdataobject)
 newposts.append(postdataobject)
 newposts.append(postdataobject)
 ///ALL postData to POSTDATA (capital P)
 }
 self.datasource = newposts
 self.collection.reloadData() //update all elements in collection
 */
 
