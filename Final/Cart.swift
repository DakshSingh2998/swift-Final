//
//  Cart.swift
//  Final
//
//  Created by Daksh on 22/02/23.
//

import SwiftUI

struct Cart: View {
    @State var deliveryTime = 0
    @Binding var cartItems:[Food]
    @Binding var gotoPage:Int
    @State var closure: (() -> Void)?
    @State var i = 0
    @State var gotoDelivery: (() -> Void)?
    @State var subTotal = 0
    @Binding var location:String
    func calcSubTotal(){
        subTotal = 0
        for i in cartItems.indices{
            subTotal = subTotal + cartItems[i].price * cartItems[i].quantity
        }
    }
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            VStack{
                ScrollView{
                    VStack(spacing: 20){
                        VStack{
                            HStack{
                                Image(systemName: "clock")
                                Text("Delivery in **\(deliveryTime)-\(deliveryTime+5)** min(s)").font(Font(CTFont(.system, size: 14)))
                                Spacer()
                            }.padding(.all, 10)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.top, 1)
                        
                        Separator(text: "ITEM(s) ADDED")
                        
                        VStack{
                            
                            ForEach(cartItems) { val in
                                HStack(alignment: .top){
                                    Image(systemName: "eye.fill")
                                    
                                    VStack(spacing: 6){
                                        HStack{
                                            
                                            Text(val.name).font(Font(CTFont(.system, size: 14))).font(Font(CTFont(.system, size: 14))).bold()
                                                .onTapGesture {
                                                    
                                                }
                                            Spacer()
                                            PlusMinus(cartItems: $cartItems, text: val.$quantity, id: val.id, subTotal: $subTotal)
                                            //Text("\(val.quantity)")
                                        }
                                        HStack{
                                            Text("₹\(val.price)").font(Font(CTFont(.system, size: 14))).font(Font(CTFont(.system, size: 14)))
                                            Spacer()
                                            Text("₹\(val.price*val.quantity)").font(Font(CTFont(.system, size: 14)))
                                        }
                                    }
                                    Spacer()
                                }.padding(.all, 10)
                                
                            }
                        }
                        //.overlay(RoundedRectangle(cornerRadius: 4).stroke(Color("Dark"), lineWidth:2))
                        .cornerRadius(10)
                        .background(Color(.white))
                        .cornerRadius(10)
                        HStack{
                            Image(systemName: "eyes.inverse")
                            Text("Add more items").font(Font(CTFont(.system, size: 14)))
                            Spacer()
                            Text(">").font(Font(CTFont(.system, size: 14)))
                        }
                        .frame(height: 40)
                        .padding(.horizontal, 10)
                        
                        .background(.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            gotoPage = 1
                        }
                        Separator(text: "BILL SUMMARY")
                        HStack{
                            VStack{
                                Text("Subtotal").font(Font(CTFont(.system, size: 18))).bold()
                            }.padding(.all, 10)
                            Spacer()
                            VStack{
                                Text("₹\(subTotal)")
                            }.padding(.all, 10)
                        }
                        .background(.white)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 10)
                }
                VStack{
                    HStack{
                        Image(systemName: "eyes.inverse")
                        Text("Delivery at **\(location)**").font(Font(CTFont(.system, size: 14)))
                        Spacer()
                        Text("Change").font(Font(CTFont(.system, size: 14))).foregroundColor(Color("Dark"))
                    }
                }.frame(height: 40)
                    .background(.white)
                    .cornerRadius(10)
                    
            }
            
            
        }
        
        .onAppear(){
            calcSubTotal()
        }
        
    }
}
struct PlusMinus:View{
    @Binding var cartItems:[Food]
    
    @State var showRemove = false
    @Binding var text:Int
    @State var id: UUID?
    @State var index = 0
    @Binding var subTotal:Int
    var body: some View{
        HStack(spacing: 5){
            Text("-").padding(.leading, 8).onTapGesture {
                for i in cartItems.indices{
                    if(id == cartItems[i].id){
                        index = i
                        break
                    }
                }
                if(cartItems[index].quantity == 1){
                    
                    showRemove = true
                    return
                }
                cartItems[index] = Food(name: cartItems[index].name, price: cartItems[index].price, quantity: cartItems[index].quantity - 1)
                subTotal = subTotal - cartItems[index].price
            }
            .alert("Do you want to remove this Item from Cart", isPresented: $showRemove, actions: {
                Button("No", role: .cancel, action: {
                    
                    showRemove = false
                })
                Button("Yes", role: .destructive, action: {
                    subTotal = subTotal - cartItems[index].price
                    cartItems.remove(at: index)
                    
                    showRemove = false
                })
            })
            Text("\(text)").font(Font(CTFont(.system, size: 14))).frame(width: 20)
            Text("+").padding(.trailing, 8).onTapGesture {
                for i in cartItems.indices{
                    if(id == cartItems[i].id){
                        index = i
                        break
                    }
                }
                cartItems[index] = Food(name: cartItems[index].name, price: cartItems[index].price, quantity: cartItems[index].quantity + 1)
                subTotal = subTotal + cartItems[index].price
                
            }
        }
        
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color("Dark"), lineWidth:2))
        .cornerRadius(4)
        .background(Color("Light"))
        .cornerRadius(4)
        .onAppear(){
            
        }
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
