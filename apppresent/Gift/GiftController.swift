//
//  GiftController.swift
//  apppresent
//
//  Created by Ky Nguyen on 3/13/19.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//
import UIKit
import Kingfisher

class GiftController:UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
   //knStaticListController,

   /* static func create() -> GiftController {
        return UIStoryboard(name: "gifting", bundle: nil).instantiateViewController(withIdentifier: "GiftController") as! GiftController
    }
 */
    
    
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
          paymentButton.addTarget(self, action: #selector(URLButtonPressed), for: .touchUpInside)
        //setupView()
    }
    
    
    let urls = ["https://i.postimg.cc/NF3whFmJ/Screen-Shot-2019-03-14-at-10-54-59.png","https://i.postimg.cc/Kzbx9JtK/Screen-Shot-2019-03-14-at-11-09-24.png", "https://i.postimg.cc/tTDQByXf/Screen-Shot-2019-03-14-at-11-10-42.png"]
    
    
    
    var data: Shop? {
        didSet {
            
            
            //bannerImageView.downloadImage(from: data?.bannerUrl)
            //logoImageView.downloadImage(from: data?.icon)
            //merchantNameLabel.text = data?.merchantName
           // titleLabel.text = data?.title
        }
    }
    
    
    
    @objc func URLButtonPressed(_ sender: Any)  {
        
        
        
        guard let url = URL(string: "https://paypal.me/pools/c/8d7DqcbHSg") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GiftSpecificCollectionViewCell
        
        if let url = urls.
        {
            do {
                
                let image = ImageResource(downloadURL: url, cacheKey: url.path)
                cell.giftImageView.kf.setImage(with: image)
                
            }
            catch {
                print("imageURL was not able to be converted into data") //
            }
            cell.giftLabel.text = urls[indexPath.row]
        
        return cell
    }
    
    
    
    
        /*
        
          UIApplication.shared.open(URL(string: "https://www.asos.com/new-look/new-look-lace-up-biker-flat-ankle-boot/prd/10240111?affid=14173&channelref=product+search&mk=abc&browsecountry=GB&currencyid=1&ppcadref=761030383%7C39786843723%7Caud-455407903566%3Apla-481059582205%26browsecountry%3DGB&_cclid=Google_Cj0KCQjwg73kBRDVARIsAF-kEH95SuhGzUhoygUKinwuKuY0GRsCI9o0kbYVa8OD4FuBR7r19R0tTSUaAnrFEALw_wcB&gclid=Cj0KCQjwg73kBRDVARIsAF-kEH95SuhGzUhoygUKinwuKuY0GRsCI9o0kbYVa8OD4FuBR7r19R0tTSUaAnrFEALw_wcB")! as URL, options:[:] , completionHandler: nil)
 */
 
 }
    
   /* @IBAction func URLButtonPressed(_ sender: Any) {
        
        //https://stackoverflow.com/questions/28010518/swift-open-web-page-in-app-button-doesnt-react
        
        
        if let url = URL(string: "https://www.google.com"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
        
        UIApplication.shared.open(URL(string: "https://www.asos.com/new-look/new-look-lace-up-biker-flat-ankle-boot/prd/10240111?affid=14173&channelref=product+search&mk=abc&browsecountry=GB&currencyid=1&ppcadref=761030383%7C39786843723%7Caud-455407903566%3Apla-481059582205%26browsecountry%3DGB&_cclid=Google_Cj0KCQjwg73kBRDVARIsAF-kEH95SuhGzUhoygUKinwuKuY0GRsCI9o0kbYVa8OD4FuBR7r19R0tTSUaAnrFEALw_wcB&gclid=Cj0KCQjwg73kBRDVARIsAF-kEH95SuhGzUhoygUKinwuKuY0GRsCI9o0kbYVa8OD4FuBR7r19R0tTSUaAnrFEALw_wcB")! as URL, options:[:] , completionHandler: nil)
    }
    */
   /*

    let categoryView = CategoryView()
    let forMeReward = RewardView(title: "Recommend places")
    let shopsView = RewardView(title: "Recommend shops")

    override func setupView() {
        view.addSubviews(views: tableView)
        tableView.fill(toView: view)
        let categoryCell = knTableCell.wrap(view: categoryView, space: UIEdgeInsets(bottom: 12))

        let forMeCell = knTableCell.wrap(view: forMeReward, space: UIEdgeInsets(bottom: 12))

        let shopCell = knTableCell.wrap(view: shopsView, space: UIEdgeInsets(bottom: 12))

        datasource = [categoryCell, forMeCell, shopCell]

        categoryView.datasource = [
            Category(icon: "1", name: "All"),
            Category(icon: "2", name: "Limit Edition"),
            Category(icon: "3", name: "Food"),
            Category(icon: "4", name: "Grab"),
            Category(icon: "5", name: "Service"),
            Category(icon: "6", name: "Shopping"),
            Category(icon: "7", name: "Entertainment"),
            Category(icon: "8", name: "Travel"),
        ]
/*
        let rewards = [
            //Reward(merchantLogo: "https://media.franoppnetwork.com/media/concept-logo/gong-cha-usa-250x250.png?v=1", merchantName: "Gong Cha", banner: "https://www.8days.sg/image/9448028/16x9/1920/1080/61d6eb71675b012fa506f1a02a98430f/tx/a68i8605.jpg", title: "Save 15%", point: 750),
            //Reward(merchantLogo: "https://media.franoppnetwork.com/media/concept-logo/gong-cha-usa-250x250.png?v=1", merchantName: "Gong Cha", banner: "https://www.8days.sg/image/9448028/16x9/1920/1080/61d6eb71675b012fa506f1a02a98430f/tx/a68i8605.jpg", title: "Save 15%", point: 750),
           // Reward(merchantLogo: "https://media.franoppnetwork.com/media/concept-logo/gong-cha-usa-250x250.png?v=1", merchantName: "Gong Cha", banner: "https://www.8days.sg/image/9448028/16x9/1920/1080/61d6eb71675b012fa506f1a02a98430f/tx/a68i8605.jpg", title: "Save 15%", point: 750)
            
        
            Reward(merchantLogo: "https://t4.ftcdn.net/jpg/01/02/98/45/240_F_102984560_hdfURvoA3oBqTWwbxxvfhGsexf9aapO7.jpg", merchantName: "ASOS", banner: "https://i.postimg.cc/NF3whFmJ/Screen-Shot-2019-03-14-at-10-54-59.png", title: "Must-have!!", point: 750),
            Reward(merchantLogo: "https://t4.ftcdn.net/jpg/01/02/98/45/240_F_102984560_hdfURvoA3oBqTWwbxxvfhGsexf9aapO7.jpg", merchantName: "ASOS", banner: "https://i.postimg.cc/Kzbx9JtK/Screen-Shot-2019-03-14-at-11-09-24.png", title: "Edgy", point: 750),
            Reward(merchantLogo: "https://t4.ftcdn.net/jpg/01/02/98/45/240_F_102984560_hdfURvoA3oBqTWwbxxvfhGsexf9aapO7.jpg", merchantName: "RADIAL", banner: "https://i.postimg.cc/tTDQByXf/Screen-Shot-2019-03-14-at-11-10-42.png", title: "Skin Freedom", point: 750)

        ]
 */
        
        // keep the layout -> you have to prepare data for cover photo
        // change layout -> simple one
        
        // thats a simpler idea than I thought you wanted to do lol
        // thats ok, but I wanted to provide a way to post urls to specific items i.e.
        // That the user inputs themselves...
        //the shop is good idea, we dont have to code the like button anymore so I like that for time! I didnt think of that
        //but another collection view or the story thing the top ( small circles) whichever is easier for the user adding links.
        // alternatively, one button (long one) that leads to a paypal (
//https://postimg.cc/PLSgJb3h/2e4148b7
        //forMeReward.datasource = rewards
        //shopsView.datasource = rewards
        
        // just a long button paypal
        // another collection view with specific items, the user would have to screenshot the page and put in the url and the name for it to go to collection view
        getShops()
    }
    
    func getShops() {
        DatabaseNode.getDb(.shops).observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let data = snapshot.value as? [String: AnyObject] else { return }
            let rawData = Array(data.values)
            let shops = rawData.map({ return Shop(raw: $0)})
            self?.shopsView.datasource = shops
        }
    }



/*
icon_url: https://s3-ap-southeast-1.amazonaws.com/images.marketing-interactive.com/wp-content/uploads/2019/01/30103253/Zara-700x700.jpg
title: "Zara"
url: https://si.wsj.net/public/resources/images/BN-TW366_36K8a_M_20170614135805.jpg

icon_url:https://www.businessinsider.com/image/53d29d5c6bb3f7a80617ada8-1200-924/nike-logo.png
title:"Nike"
url:https://cdn.filepicker.io/api/file/b7KpCA7bSzqq4IhV0CCQ


icon_url:http://compassiongames.org/wp-content/uploads/2015/07/Lush-logo.png
title: "LUSH"
url:http://res.cloudinary.com/lush/image/upload/v1392284174/shops/hero/101.jpg


icon_url:https://www.nandos.co.uk/sites/default/files/Full%20Logo%20Horizontal.jpgtitle: "Godiva"
title:"Nando's"
url: https://www.sickchirpse.com/wp-content/uploads/2018/02/Nandos-Fries.jpg

icon_url: https://futureconsiderations.com/wp-content/uploads/2012/02/tate-logo.jpg
title:"Tate Art Museum"
url:https://www.standard.co.uk/s3fs-public/thumbnails/image/2013/05/16/08/AN_20860739-(Read-Only).gif

icon_url:https://is1-ssl.mzstatic.com/image/thumb/Purple128/v4/55/37/14/55371493-c33e-6601-143e-c6c3c757600e/AppIcon-1x_U007emarketing-0-85-220-0-5.png/246x0w.jpg
title: "Apollo Victoria Theatre"
url: https://www.theapollovictoria.com/img/home/auditorium.jpg

icon_url:https://www.cadbury.co.uk/~/media/cadburydev/uk/Images/merlin/images/merlin/attractions/THORPE-PARK-Logo.jpg
title:"Thorpe Park"
url:https://www.virginexperiencedays.co.uk/content/img/product/large/one-night-break-with-25132712.jpg

name: "Accesorise bag"
url: https://www.asos.com/accessorize/accessorize-straw-effect-basket-tote-bag/prd/11604396?clr=natural&SearchQuery=&cid=9736&gridcolumn=1&gridrow=1&gridsize=4&pge=1&pgesize=72&totalstyles=136


name: "Nike Trainers"
url: https://www.office.co.uk/view/product/office_catalog/5,22/2003110508080?gclid=Cj0KCQjwg73kBRDVARIsAF-kEH-NCehkMUvyfJxcUEcsVH56DI7Q4oKU9JYBXOBSB6Pxu3WOlU0MEYkaAjIkEALw_wcB

name: "Office boots"
url: https://www.office.co.uk/view/product/office_catalog/1,41/7205800078090?gclid=Cj0KCQjwg73kBRDVARIsAF-kEH_3RG_Iwt9Pvngb6THWORhI3Yk-PsaVh3wFk0Wqh-XrYmaATQyEZJoaAhyBEALw_wcB


name: "Caffiene Skin Care"
url: https://www.skinstore.com/the-ordinary-caffeine-solution-5-egcg-30ml/11396686.html?affil=thggpsad&switchcurrency=GBP&shippingcountry=GB&&thg_ppc_campaign=71700000015222117&gclid=Cj0KCQjwg73kBRDVARIsAF-kEH-OEGAjvSqmYjtkfS1pKSk297eO9pVqOe0JBF3_E-VFjQyDnYWYOL0aAmf-EALw_wcB&gclsrc=aw.ds
 
 */

// you need:
// api for shops or put shops data into firebase
// api for places or put shops data into firebase
// give links list -> icons and title
// icon_url: String, title; String, url: String
// icon_url: ttps://nike.com/logo.png
// ittle; NIke
// url: https:// nike.com

// I'll add to Firebase
// Shall I make the page for the user to add it, or wait?
// So hwo does this one work
// So I create an account and it is already filled with information or it is empty and I add it myself?
// That's only thing I wasnt sure about. So the use will adda place image url, a place title for every place for firebase, the same with shop and the same with the top icons (with an added website link)

// you're the admin of the app, you add everthing into firebase
// your users open the app and see what you added
// next reelase: they can add their favorite one.
// -> you save that data to firebase
// other usres can see new places (added by other users)
// your usres make data for you

// this gift page belongs to current logged in user, when you view another users account, they have their own gift page that they edited, its not central? is that ok. So I fill it initially, the next release they can edit or remove things? what is simples to do? But originally its your own gift page to tell people what gifts to buy you, from where and what clothes youve been looking at online.

// Maybe I just do the links on a page arrangement and their is one page of links for the current user and one for other users. From research people like the links best? Can I do that? No shops or places just a colleciton view that goes to links.

// They go unot my profile page which leads them to the gift view controller with my stuff in it. Like the profile page which is one view controller many users.
*/
