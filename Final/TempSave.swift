/*
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
     @Binding var gst:Double
     @State var gstAmt = 0.0
     @State var grandTotal = 0.0
     @State var gstInfo = false
     
     func calcSubTotal(){
         subTotal = 0
         for i in cartItems.indices{
             subTotal = subTotal + cartItems[i].price * cartItems[i].quantity
         }
     }
     var body: some View {
         ZStack{
             LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
             VStack(spacing: 0){
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
                         .background(Color("Light"))
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
                                             PlusMinus(cartItems: $cartItems, food: val, id: val.id, subTotal: $subTotal)
                                             //Text("\(val.quantity)")
                                         }
                                         HStack{
                                             Text("₹\(val.price)").font(Font(CTFont(.system, size: 14))).font(Font(CTFont(.system, size: 14)))
                                             Spacer()
                                             Text("₹\(val.price*val.quantity)").font(Font(CTFont(.system, size: 14)))
                                         }
                                     }
                                     Spacer()
                                 }.padding(.horizontal, 10)
                                     .padding(.vertical, 6)
                                 
                             }
                         }
                         //.overlay(RoundedRectangle(cornerRadius: 4).stroke(Color("Dark"), lineWidth:2))
                         .cornerRadius(10)
                         .background(Color("Light"))
                         .cornerRadius(10)
                         HStack{
                             Image(systemName: "plus.circle")
                             Text("Add more items").font(Font(CTFont(.system, size: 14)))
                             Spacer()
                             Text(">").font(Font(CTFont(.system, size: 14)))
                         }
                         .frame(height: 40)
                         .padding(.horizontal, 10)
                         
                         .background(Color("Light"))
                         .cornerRadius(10)
                         .onTapGesture {
                             gotoPage = 1
                         }
                         Separator(text: "BILL SUMMARY")
                         VStack{
                             HStack{
                                 VStack(alignment: .leading, spacing: 10){
                                     Text("Subtotal").font(Font(CTFont(.system, size: 14))).bold()
                                     HStack{
                                         Image(systemName: "building.columns.circle")
                                             .frame(width: 20, height: 20)
                                         Text("Gst \(String(format: "%.2f", gst))% ⓘ").font(Font(CTFont(.system, size: 12))).onTapGesture {
                                             gstInfo = true
                                         }
                                         .alert(isPresented: $gstInfo){
                                             Alert(title: Text("GST INFO"), message: Text("Our App has no role to play in taxes being levied by govt and restaurants"), dismissButton: .default(Text("Got It!")))
                                         }
                                     }
                                     
                                     
                                 }
                                 .padding(.top, 10)
                                 .padding(.horizontal, 10)
                                 Spacer()
                                 VStack(alignment: .trailing, spacing: 10){
                                     Text("₹\(subTotal)").font(Font(CTFont(.system, size: 14))).bold()
                                     Text("₹\(String(format: "%.2f", gstAmt))").font(Font(CTFont(.system, size: 12)))
                                     
                                 }
                                 .padding(.top, 10)
                                 .padding(.horizontal, 10)
                             }
                             VStack{
                             }
                             .frame(maxWidth: .infinity)
                             .frame(height: 1)
                             .background(Color("Dark"))
                             .cornerRadius(20)
                             .padding(.horizontal, 10)
                             HStack{
                                 VStack(alignment: .leading, spacing: 10){
                                     Text("Grand Total").font(Font(CTFont(.system, size: 14))).bold()
                                 }
                                 .padding(.bottom, 10)
                                 .padding(.horizontal, 10)
                                 Spacer()
                                 VStack(alignment: .trailing, spacing: 10){
                                     Text("₹\(String(format: "%.2f", grandTotal))").font(Font(CTFont(.system, size: 14))).bold()
                                 }
                                 .padding(.bottom, 10)
                                 .padding(.horizontal, 10)
                                 
                                 
                             }
                             
                         }.background(Color("Light"))
                             .cornerRadius(10)
                         ////Cancellation
                         Separator(text: "CANCELLATION POLICY")
                         
                         VStack{
                             Text("Orders once placed cannot be cancelled and are non-refundable")
                                 .font(Font(CTFont(.system, size: 14))).foregroundColor(.red).multilineTextAlignment(.center)
                                 .padding(.all, 10)
                                 
                         }.frame(maxWidth: .infinity)
                         .background(Color("Light"))
                         .cornerRadius(10)
                     }
                     .padding(.horizontal, 10)
                     
                     VStack{
                         
                     }
                     .frame(maxWidth: .infinity, minHeight: 20)
                     .background(.clear)
                     .ignoresSafeArea()
                     
                 }.padding(.bottom, -20)
                 Spacer()
                 VStack{
                     HStack{
                         Image(systemName: "eyes.inverse")
                         Text("Delivery at **\(location)**").font(Font(CTFont(.system, size: 14)))
                         Spacer()
                         Text("Change")
                             .foregroundColor(.red)
                             .font(Font(CTFont(.system, size: 14)))
                     }
                     .padding(.horizontal, 10)
                 }.frame(height: 40)
                     .background(Color("Light"))
                     .cornerRadius(10)
                     
             }
             
             
         }
         
         .onAppear(){
             calcSubTotal()
         }
         .onChange(of: subTotal, perform: {newVal in
             gstAmt = Double(subTotal)*gst/100
             gstAmt = Double(round(100 * gstAmt) / 100)
             grandTotal = Double(subTotal) + gstAmt
         })
         
     }
 }
 struct PlusMinus:View{
     @Binding var cartItems:[Food]
     
     @State var showRemove = false
     @State var food:Food
     @State var id: UUID?
     @State var index = 0
     @Binding var subTotal:Int
     var body: some View{
         HStack(spacing: 2){
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
             Text("\(food.quantity)").font(Font(CTFont(.system, size: 14))).frame(width: 20)
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
         .background(Color("LightDark"))
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
             .frame(height: 1)
                 
                 .background(Color("Dark"))
             
             Text(text)
                 .fixedSize()
                 .font(Font(CTFont(.system, size: 16)))
                 .lineLimit(1)
             
             VStack{
                 
             }.frame(height: 1)
                 .frame(maxWidth: .infinity)
                 .background(Color("Dark"))
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
