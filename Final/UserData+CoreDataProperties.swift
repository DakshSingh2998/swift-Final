//
//  UserData+CoreDataProperties.swift
//  Final
//
//  Created by Daksh on 17/03/23.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var dob: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var toCartItem: NSOrderedSet?

}

// MARK: Generated accessors for toCartItem
extension UserData {

    @objc(insertObject:inToCartItemAtIndex:)
    @NSManaged public func insertIntoToCartItem(_ value: CartItemDish, at idx: Int)

    @objc(removeObjectFromToCartItemAtIndex:)
    @NSManaged public func removeFromToCartItem(at idx: Int)

    @objc(insertToCartItem:atIndexes:)
    @NSManaged public func insertIntoToCartItem(_ values: [CartItemDish], at indexes: NSIndexSet)

    @objc(removeToCartItemAtIndexes:)
    @NSManaged public func removeFromToCartItem(at indexes: NSIndexSet)

    @objc(replaceObjectInToCartItemAtIndex:withObject:)
    @NSManaged public func replaceToCartItem(at idx: Int, with value: CartItemDish)

    @objc(replaceToCartItemAtIndexes:withToCartItem:)
    @NSManaged public func replaceToCartItem(at indexes: NSIndexSet, with values: [CartItemDish])

    @objc(addToCartItemObject:)
    @NSManaged public func addToToCartItem(_ value: CartItemDish)

    @objc(removeToCartItemObject:)
    @NSManaged public func removeFromToCartItem(_ value: CartItemDish)

    @objc(addToCartItem:)
    @NSManaged public func addToToCartItem(_ values: NSOrderedSet)

    @objc(removeToCartItem:)
    @NSManaged public func removeFromToCartItem(_ values: NSOrderedSet)

}

extension UserData : Identifiable {

}
