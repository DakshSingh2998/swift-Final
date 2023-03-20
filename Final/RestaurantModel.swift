//
//  RestaurantModel.swift
//  Final
//
//  Created by Daksh on 07/03/23.
//

import Foundation
struct RestaurantModel: Encodable, Hashable{
    var isVeg:Bool?
    var distance:Double?
    var price:Int?
    var isLiked:Bool?
    var id:Int?
    var category:String?
    var rating:String?
    var name:String?
    var location:String?
    
    
    init(data: [String:Any]){
        if let isVeg = data["D"]{ self.isVeg = isVeg as? Bool
        }
        if let distance = data["F"]{ self.distance = Double((distance as? String)!) ?? 0
        }
        if let price = data["G"]{ self.price = Int((price as? String)!) ?? 0
        }
        if let isLiked = data["H"]{ self.isLiked = isLiked as? Bool
        }
        if let id = data["id"]{ self.id = Int("\(id)") ?? 0
        }
        if let category = data["col1"]{ self.category = category as? String
        }
        if let rating = data["rating"]{ self.rating = rating as? String
        }
        if let name = data["fullName"]{ self.name = name as? String
        }
        if let location = data["I"]{ self.location = location as? String
        }
    }
    init(isVeg:Bool?, distance:Double?, price:Int?, isLiked:Bool?, id:Int?, category:String?, rating:String?, name:String?, location:String?){
        self.isVeg = isVeg
        self.distance = distance
        self.price = price
        self.isLiked = isLiked
        self.id = id
        self.category = category
        self.rating = rating
        self.name = name
        self.location = location
        
    }
}
