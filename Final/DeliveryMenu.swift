//
//  DeliveryMenu.swift
//  Final
//
//  Created by Daksh on 21/02/23.
//

import SwiftUI

struct DeliveryMenu: View {
    @Binding var cartItems:[Food]
    var body: some View {

            VStack{
                
            }.frame(height: 800)
            .onAppear(){
                cartItems.append(Food(name: "Margherita", price: 100, quantity: 1))
            }
        
        
    }
}
/*
 struct DeliveryMenu_Previews: PreviewProvider {
 static var previews: some View {
 DeliveryMenu()
 }
 }
 */
