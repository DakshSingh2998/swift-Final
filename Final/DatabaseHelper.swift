//
//  DatabaseHelper.swift
//  First
//
//  Created by Daksh on 09/02/23.
//

import CoreData
import UIKit
import Foundation
import SwiftUI
struct DatabaseHelper{
    //@Environment(\.managedObjectContext) var context
    var context = PersistenceController.shared.container.viewContext
    static var shared = DatabaseHelper()
    func saveUser(name:String, email:String, password:String, dob:String){
        let obj = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context) as! UserData
        obj.name = name
        obj.email = email
        obj.password = password
        obj.dob = dob
        do{
            try? context.save()
        }
        catch{
            print("Error in saving")
        }
    }
    func loadUsers() -> [UserData]{
        var obj:[UserData] = []
        //let fetchreq = NSFetchRequest<NSManagedObject>(entityName: "Movies")
        do{
            obj = try context.fetch(NSFetchRequest(entityName: "UserData")) as! [UserData]
        }
        catch{
            print("Error in loading")
        }
        return obj
    }
    
    func loadCart() -> [CartItemDish]{
        var obj:[CartItemDish] = []
        //let fetchreq = NSFetchRequest<NSManagedObject>(entityName: "Movies")
        do{
            obj = try context.fetch(NSFetchRequest(entityName: "CartItemDish")) as! [CartItemDish]
        }
        catch{
            print("Error in loading")
        }
        return obj
    }
    
    func updateCart(cartItems:[Food], userData:UserData){
        if(userData == nil){
            return
        }
        var obj:[CartItemDish] = []
        //let fetchreq = NSFetchRequest<NSManagedObject>(entityName: "Movies")
        do{
            obj = try context.fetch(NSFetchRequest(entityName: "CartItemDish")) as! [CartItemDish]
            var copy = obj
            obj = []
            for i in 0..<copy.count{
                if(copy[i].toUserData! == userData){
                    
                }
                else{
                    obj.append(copy[i])
                }
            }
            userData.toCartItem = []
            for i in 0..<cartItems.count{
                var temp = NSEntityDescription.insertNewObject(forEntityName: "CartItemDish", into: context) as! CartItemDish
                temp.name = cartItems[i].name
                temp.price = Int64(cartItems[i].price)
                temp.quantity = Int64(cartItems[i].quantity)
                temp.restaurantName = cartItems[i].restaurantName
                temp.toUserData = userData
                userData.addToToCartItem(temp)
                obj.append(temp)
            }
            try? context.save()
        }
        catch{
            print("Error in loading")
        }
    }
    
    /*
    func deleteData(object:Movies) -> [Movies]{
        var movies = loadData()
        var toDelete:Movies? = nil
        var i = 0
        for ele in movies{
            if(ele == object){
                toDelete = ele
                break
            }
            i = i+1
        }
        if(toDelete == nil){
            return movies
        }
        
        do{
            try? context?.delete(toDelete!)
            try? (UIApplication.shared.delegate as?
                  AppDelegate)?.saveContext()
            
        }
        catch{
            print("Error in deleting")
        }
        movies.remove(at: i)
        return movies
    }
    func updateData(object:Movies, title:String? = "", language:String? = ""){
        var movies = loadData()
        var i = 0
        for ele in movies{
            if(ele == object){
                break
            }
            i = i+1
        }
        if(title != ""){
            object.title = title
        }
        if(language != ""){
            object.language = language
        }
        movies[i] = object
        
        do{
            try? context?.save()
        }
    }
    */
}

