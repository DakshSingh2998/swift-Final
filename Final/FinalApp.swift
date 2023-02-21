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
    var body: some Scene {
        WindowGroup {
            HomePage()
        }
    }
}
