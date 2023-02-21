//
//  HomePage.swift
//  Final
//
//  Created by Daksh on 21/02/23.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        TabView{
            Group{
                DeliveryMenu()
                    .tabItem{
                        Label("Delivery", systemImage: "eye.fill").background(.green)
                    }
                GroceryMenu()
                    .tabItem{
                        Label("Grocery", systemImage: "eyes.inverse")
                    }
            }
                
            
        }
        //.tabViewStyle(.page)
        .onAppear(){
        }
        .accentColor(.red)
//        .toolbarColorScheme(/*@START_MENU_TOKEN@*/.light/*@END_MENU_TOKEN@*/)
//        .preferredColorScheme(/*@START_MENU_TOKEN@*/.light/*@END_MENU_TOKEN@*/)
//        .colorMultiply(/*@START_MENU_TOKEN@*/.purple/*@END_MENU_TOKEN@*/)
//        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
//        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
