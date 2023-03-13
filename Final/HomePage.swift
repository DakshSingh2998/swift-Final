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
    @State var restaurantName = ""
}
enum PaymentMode{
    case cash, upi
}
struct HomePage: View {
    @Environment(\.dismiss) var dismiss
    @State var onPage = 1
    @Binding var ONPAGE: Double
    @State var temp = ""
    @State var cartItems:[Food] = []
    @State var location = "Rapipay"
    @State var gst = 15.80651654
    @State var distance = 5.0
    @State var paymentMode = PaymentMode.cash
    @State var deliveryTime = 20
    @State var restaurantModel:[RestaurantModel] = []
    @State var userData:UserData?
    
    func addDummyData(){
        cartItems = []
        cartItems.append(Food(name: "Margherita", price: 100, quantity: 1))
        cartItems.append(Food(name: "Double Cheese Margherita", price: 149, quantity: 1))
        cartItems.append(Food(name: "Onion", price: 9999, quantity: 1))
        
        for i in 4...10{
            
            cartItems.append(Food(name: "Temp", price: i, quantity: 1))
        }
    }
    var body: some View {
        NavigationView{
            TabView(selection: $onPage){
                DeliveryMenu(cartItems: $cartItems, onPage: $onPage, ONPAGE: $ONPAGE, restaurantModel: $restaurantModel)
                    .tabItem{
                        Label("Delivery", systemImage: "eye.fill").background(.green)
                    }.tag(1)
                
                
                GroceryMenu(ONPAGE: $ONPAGE)
                    .tabItem{
                        Label("Grocery", systemImage: "basket")
                    }.tag(2)
                
                Cart(deliveryTime: $deliveryTime, cartItems: $cartItems, gotoPage: $onPage, location: $location, gst: $gst, paymentMode: $paymentMode, distance: $distance, ONPAGE: $ONPAGE, userData: userData)
                    .tabItem{
                        Label("Cart", systemImage: "cart")
                        
                    }.tag(3)
                
            }.frame(maxHeight: .infinity)
            VStack{
                
            }.frame(width: 2, height: 20)
            
        }.navigationViewStyle(.stack)
        .frame(maxHeight: .infinity)
        .navigationBarHidden(true)
            .accentColor(onPage == 1 ? .brown : onPage == 2 ? Color("GroceryBorder") : Color("Dark"))

            .onAppear(){
                print(userData)
                var cartItemDish :[CartItemDish] = DatabaseHelper.shared.loadCart()
                for i in 0..<cartItemDish.count{
                    cartItems.append(Food(name: cartItemDish[i].name!, price: Int(cartItemDish[i].price), quantity: Int(cartItemDish[i].quantity), restaurantName: cartItemDish[i].restaurantName!))
                }
                print("ONPAGE4 \(ONPAGE)")
                UITableView.appearance().separatorStyle = .none
                UITableViewCell.appearance().tintColor = .systemPink
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                gst = gst.roundTo()
                distance = distance.roundTo()
                
                //addDummyData()
                
            }
        .onChange(of: ONPAGE){ newVal in
            if(ONPAGE < 4.0){
                try? dismiss()
            }
        }
        
    }
}



/*

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

*/
