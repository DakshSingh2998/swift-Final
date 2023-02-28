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
    @State var ONPAGE:Double = 1.0
    var body: some Scene {
        WindowGroup {
            //HomePage()
            FirstPage(ONPAGE: $ONPAGE)
            //Profile()
        }
    }
}
