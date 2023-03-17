//
//  CartItemDish+CoreDataProperties.swift
//  Final
//
//  Created by Daksh on 17/03/23.
//
//

import Foundation
import CoreData


extension CartItemDish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItemDish> {
        return NSFetchRequest<CartItemDish>(entityName: "CartItemDish")
    }

    @NSManaged public var isVeg: Bool
    @NSManaged public var name: String?
    @NSManaged public var price: Int64
    @NSManaged public var quantity: Int64
    @NSManaged public var restaurantName: String?
    @NSManaged public var distance: Double
    @NSManaged public var toUserData: UserData?

}

extension CartItemDish : Identifiable {

}
