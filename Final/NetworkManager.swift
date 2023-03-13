//
//  NetworkManager.swift
//  API
//
//  Created by Daksh on 01/02/23.
//

import Foundation
import SwiftUI
struct NetworkManager{
    static var shared = NetworkManager()
    
    
    func getApi(url:String, completition: ((Any)->())?){
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request){
            data, response, err in
            if let err = err{
                print(err.localizedDescription)
                return
            }
            guard let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) else{
                print("SERL ERR")
                return
            }
            //print(jsonData)
            completition?(jsonData)
        }.resume()
        
    }
    func postApi(url:String, putJsonData:Data, completition: ((Any)->())?){
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "PUT"
        request.httpBody = putJsonData
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request){
            data, response, err in
            if let err = err{
                print(err.localizedDescription)
                return
            }
            guard let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) else{
                print("SERL ERR")
                return
            }
            //print(jsonData)
            completition?(jsonData)
        }.resume()
        
        
    }
}
