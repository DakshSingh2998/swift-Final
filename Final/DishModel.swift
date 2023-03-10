//
//  DishModel.swift
//  Final
//
//  Created by Daksh on 09/03/23.
//

import Foundation
struct DishModel: Hashable{
    var name:String?
    var price:Int?
    var imageUrl:String?
    var id:Int?
    var rating:String?
    var description:String?
    var votes:Int?
    var isVeg:Bool?
    //var contentIdx = 0
    
    
    init(data: [String:Any]){
        if let name = data["D"]{ self.name = name as? String
        }
        if let price = data["E"]{ self.price = Int((price as? String)!) ?? 0
        }
        if let imageUrl = data["G"]{ self.imageUrl = imageUrl as? String
        }
        if let id = data["id"]{ self.id = Int("\(id)") ?? 0
        }
        if let rating = data["col1"]{ self.rating = rating as? String
        }
        if let description = data["col2"]{ self.description = description as? String
        }
        if let votes = data["col3"]{ self.votes = Int("\(votes)") ?? 0
        }
        if let isVeg = data["isUser"]{ self.isVeg = isVeg as! String == "true" ? true : false
        }
        
       
        
    }
    init(name:String?, price:Int?, imageUrl:String?, id:Int?, rating:String?, description:String?, votes:Int?, isVeg:Bool?){
        self.name = name
        self.price = price
        self.imageUrl = imageUrl
        self.id = id
        self.rating = rating
        self.description = description
        self.votes = votes
        self.isVeg = isVeg
        //self.contentIdx = contentIdx
    }
}
