//
//  RestaurantModel.swift
//  Final
//
//  Created by Daksh on 07/03/23.
//

import Foundation
struct RestaurantModel: Identifiable{
    var isVeg:Bool?
    var category:Int?
    var price:Int?
    var isLiked:Bool?
    var id:Int?
    var location:String?
    var rating:String?
    var name:String?
    
    
    init(data: [String:Any]){
        if let isVeg = data["D"]{ self.isVeg = isVeg as? Bool
        }
        if let category = data["F"]{ self.category = Int((category as? String)!) ?? 0
        }
        if let price = data["G"]{ self.price = Int((price as? String)!) ?? 0
        }
        if let isLiked = data["H"]{ self.isLiked = isLiked as? Bool
        }
        if let id = data["id"]{ self.id = Int("\(id)") ?? 0
        }
        if let location = data["col1"]{ self.location = location as? String
        }
        if let rating = data["rating"]{ self.rating = rating as? String
        }
        if let name = data["fullName"]{ self.name = name as? String
        }
    }
    init(isVeg:Bool?, category:Int?, price:Int?, isLiked:Bool?, id:Int?, location:String?, rating:String?, name:String?){
        self.isVeg = isVeg
        self.category = category
        self.price = price
        self.isLiked = isLiked
        self.id = id
        self.location = location
        self.rating = rating
        self.name = name
        
    }
}
