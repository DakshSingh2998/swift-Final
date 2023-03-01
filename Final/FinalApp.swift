//
//  FinalApp.swift
//  Final
//
//  Created by Daksh on 01/01/15.
//

import SwiftUI

@main
struct FinalApp: App {
    let persistenceController = PersistenceController.shared
    @State var ONPAGE:Double
    init() {
        var loggedInUser = UserDefaults.standard.value(forKey: "loggedInUser")
        print(loggedInUser)
        if(loggedInUser == nil){
            ONPAGE = 1.0
        }
        else{
            ONPAGE = 4.0
        }
        
    }
    var body: some Scene {
        WindowGroup {
            if(ONPAGE <= 3.0){
                FirstPage(ONPAGE: $ONPAGE)
            }
            
            if(ONPAGE >= 4.0){
                HomePage(ONPAGE: $ONPAGE)
            }
            
            //Profile()
        }
        
    }
}
