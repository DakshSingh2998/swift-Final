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
    
    var url = "https://retoolapi.dev/fX72QN/data"
    
    func getApi(completition: ((Any)->())?){
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
            print(jsonData)
            completition?(jsonData)
        }.resume()
        
        
    }
}
