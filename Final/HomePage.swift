//
//  HomePage.swift
//  Final
//
//  Created by Daksh on 21/02/23.
//

import SwiftUI
struct Food: Identifiable{
    @State var id = UUID()
    @State var name = ""
    @State var price = 0
    @State var quantity = 0
}
enum PaymentMode{
    case cash, upi
}
struct HomePage: View {
    @State var onPage = 1
    @State var temp = ""
    @State var cartItems:[Food] = []
    @State var location = "Rapipay"
    @State var gst = 10.0
    @State var paymentMode = PaymentMode.cash
    func addDummyData(){
        cartItems = []
        cartItems.append(Food(name: "Margherita", price: 100, quantity: 1))
        cartItems.append(Food(name: "Double Cheese Margherita", price: 149, quantity: 1))
        cartItems.append(Food(name: "Onion", price: 9999, quantity: 1))
        
        for i in 4...100{
            
            cartItems.append(Food(name: "Temp", price: i, quantity: 1))
        }
    }
    var body: some View {
        
        TabView(selection: $onPage){
            DeliveryMenu()
                .tabItem{
                    Label("Delivery", systemImage: "eye.fill").background(.green)
                }.tag(1)
                
                
            GroceryMenu()
                .tabItem{
                    Label("Grocery", systemImage: "eyes.inverse")
                }.tag(2)
                
            Cart(cartItems: $cartItems, gotoPage: $onPage, location: $location, gst: $gst, paymentMode: $paymentMode)
                .tabItem{
                    Label("Cart", systemImage: "eye")
                        
                }.tag(3)
                
        }
        
        //.tabViewStyle(.page)
        .accentColor(onPage == 1 ? .brown : onPage == 2 ? Color("GroceryBorder") : Color("Dark"))
        
//        .toolbarColorScheme(/*@START_MENU_TOKEN@*/.light/*@END_MENU_TOKEN@*/)
//        .preferredColorScheme(/*@START_MENU_TOKEN@*/.light/*@END_MENU_TOKEN@*/)
//        .colorMultiply(/*@START_MENU_TOKEN@*/.purple/*@END_MENU_TOKEN@*/)
//        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
//        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
        .onAppear(){
            //UITabBar.appearance().shadowImage = UIImage(named: "ShadowImage")
            UITableView.appearance().separatorStyle = .none
            UITableViewCell.appearance().tintColor = .systemPink
            addDummyData()
            
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
