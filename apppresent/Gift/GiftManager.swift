//
//  GiftManager.swift
//  apppresent
//
//  Created by Macbook Pro on 18/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


struct Shop {
    var id: String?
    var icon: String?
    var title: String?
    var url: String?
    
    init(raw: AnyObject) {
        id = raw["id"] as? String
        icon = raw["icon"] as? String
        title = raw["title"] as? String
        url = raw["url"] as? String
    }
    
    init(title: String, icon: String, url: String) {
        id = UUID().uuidString
        self.title = title
        self.icon = icon
        self.url = url
    }
    
    func toDict() -> [String: Any] {
        var dict = [String: Any]()
        if let data = id {
            dict["id"] = data
        }
        
        if let data = icon {
            dict["icon"] = data
        }
        
        if let data = title {
            dict["title"] = data
        }
        
        if let data = url {
            dict["url"] = data
        }
        
        return dict
    }
}

struct GiftManager {
    
    
    static func addShops() {
        let db = DatabaseNode.getDb(.shops)
        
        let shops = [
            Shop(title: "ASOS",
                 icon: "",
                 url: "https://i.postimg.cc/NF3whFmJ/Screen-Shot-2019-03-14-at-10-54-59.png"),
            Shop(title: "ASOS",
                 icon: "",
                 url: "https://i.postimg.cc/Kzbx9JtK/Screen-Shot-2019-03-14-at-11-09-24.png"),
            
            Shop(title: "ASOS",
            icon: "",
            url: "https://i.postimg.cc/tTDQByXf/Screen-Shot-2019-03-14-at-11-10-42.png")
            
            
        ]
        
        for shop in shops where shop.id != nil {
            db.child(shop.id!).setValue(shop.toDict())
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
    }
}

