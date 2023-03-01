//
//  DeliveryMenu.swift
//  Final
//
//  Created by Daksh on 21/02/23.
//

import SwiftUI

struct DeliveryMenu: View {
    @Binding var cartItems:[Food]
    @Binding var onPage:Int
    @Binding var ONPAGE:Double
    var body: some View {
        ZStack(alignment: .top){
            LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            /*
            VStack{
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .overlay()
             */
            VStack(spacing: 0){
                CustomNavigation(title: "Delivery" , ONPAGE: $ONPAGE, leftImage: "location.north.circle.fill")
                    .frame(height: 64)
                    .frame(maxWidth: .infinity)
                    .frame(height: 64)
                    
                
                List{
                    
                    ForEach(cartItems) { item in
                        VStack{
                            //Text(item.name)
                            FoodItemCell().frame(height: 200)
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                }
                .background(.clear)
                .padding(.horizontal, -20)
                
                    
                    
                    
                
            }
            
            
            
            
        }
        //.frame(maxWidth: .infinity)
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
