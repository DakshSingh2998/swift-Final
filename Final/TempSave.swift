//
//  Cart.swift
//  Final
//
//  Created by Daksh on 22/02/23.
//
/*
import SwiftUI

struct Cart: View {
    @State var deliveryTime = 0
    @Binding var cartItems:[Food]
    @State var closure: (() -> Void)?
    @State var i = 0
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            ScrollView{
                VStack(spacing: 20){
                    VStack{
                        HStack{
                            Image(systemName: "clock.fill")
                            Text("Delivery in **\(deliveryTime)-\(deliveryTime+5)** min(s)").font(Font(CTFont(.system, size: 14)))
                            Spacer()
                        }.padding(.all, 8)
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .padding(.top, 1)
                    
                    Separator(text: "ITEM(s) ADDED")
                    
                    Table(cartItems){
                        TableColumn("One"){ val in
                            HStack(alignment: .top){
                                Image(systemName: "eye.fill")
                                
                                VStack(spacing: 6){
                                    HStack{
                                        
                                        Text(val.name).font(Font(CTFont(.system, size: 14))).font(Font(CTFont(.system, size: 14))).bold()
                                            .onTapGesture {
                                                
                                            }
                                        Spacer()
                                        PlusMinus(cartItems: $cartItems, text: val.$quantity)
                                        //Text("\(val.quantity)")
                                    }
                                    HStack{
                                        Text("₹\(val.price)").font(Font(CTFont(.system, size: 14))).font(Font(CTFont(.system, size: 14)))
                                        Spacer()
                                        Text("₹\(val.price*val.quantity)").font(Font(CTFont(.system, size: 14)))
                                    }
                                }
                                Spacer()
                            }.padding(.top, 8)
                            
                        }
                    }
                    //.frame(minHeight: 0)
                    
                    
                        .cornerRadius(20)
                    
                }
                .padding(.horizontal, 10)
            }
            
            
        }
        
    }
}
struct PlusMinus:View{
    @Binding var cartItems:[Food]
    @Binding var text:Int
    var body: some View{
        HStack(spacing: 10){
            Text("-").padding(.leading, 8).onTapGesture {
                cartItems[0] = Food(name: cartItems[0].name, price: cartItems[0].price, quantity: cartItems[0].quantity - 1)
            }
            Text("\(text)").font(Font(CTFont(.system, size: 14))).frame(width: 20)
            Text("+").padding(.trailing, 8).onTapGesture {
                cartItems[0] = Food(name: cartItems[0].name, price: cartItems[0].price, quantity: cartItems[0].quantity + 1)
                
                
            }
        }
        
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color("Dark"), lineWidth:2))
        .cornerRadius(4)
        .background(Color("Light"))
        .cornerRadius(4)
        
        
    }
}
struct Separator:View{
    @State var text = ""
    var body: some View{
        HStack{
            VStack{
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 2)
                
                .background(Color("Light"))
            Text(text).font(Font(CTFont(.system, size: 14)))
                .lineLimit(1)
            VStack{
                
            }.frame(height: 2)
                .frame(maxWidth: .infinity)
                .background(Color("Light"))
        }
    }
}
/*
struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        Cart()
    }
}
*/
*/
