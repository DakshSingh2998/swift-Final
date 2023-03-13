//
//  UserData+CoreDataProperties.swift
//  Final
//
//  Created by Daksh on 13/03/23.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var dob: String?
    @NSManaged public var toCartItem: NSSet?

}

// MARK: Generated accessors for toCartItem
extension UserData {

    @objc(addToCartItemObject:)
    @NSManaged public func addToToCartItem(_ value: CartItemDish)

    @objc(removeToCartItemObject:)
    @NSManaged public func removeFromToCartItem(_ value: CartItemDish)

    @objc(addToCartItem:)
    @NSManaged public func addToToCartItem(_ values: NSSet)

    @objc(removeToCartItem:)
    @NSManaged public func removeFromToCartItem(_ values: NSSet)

}

extension UserData : Identifiable {

}
