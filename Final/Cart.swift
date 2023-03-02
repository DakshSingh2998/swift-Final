//
//  Cart.swift
//  Final
//
//  Created by Daksh on 22/02/23.
//

import SwiftUI

struct Cart: View {
    @Binding var deliveryTime:Int
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
    @Binding var paymentMode:PaymentMode
    @Binding var distance:Double
    @State var showDeliveryInfo = false
    @State var gotoProfile = false
    @Binding var ONPAGE:Double
    func calcSubTotal(){
        subTotal = 0
        for i in cartItems.indices{
            subTotal = subTotal + cartItems[i].price * cartItems[i].quantity
        }
    }
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            if(cartItems.count != 0){
                VStack(spacing: 0){
                    VStack{
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 64)
                    .overlay(CustomNavigation(title: "Cart" , ONPAGE: $ONPAGE, leftImage: "location.north.circle.fill"))
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
                            
                            
                            
                            List(cartItems) { val in
                                HStack(alignment: .top){
                                    Image(systemName: "eye.fill")
                                    
                                    VStack(spacing: 0){
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
                                }
                                
                                .frame(height: 50)
                                .listRowBackground(Color("Light"))
                                
                            }
                            .listStyle(.plain)
                            .scrollDisabled(true)
                            .frame(height: 72 * CGFloat(cartItems.count))
                            .frame(maxWidth: .infinity)
                            .cornerRadius(20)
                            
                            
                            
                            
                            
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
                                //gotoPage = 1
                                gotoProfile = true
                            }
                            Separator(text: "BILL SUMMARY")
                            
                            ////////////billing
                            VStackLayout(alignment: .leading, spacing: 6){
                                /*
                                 HStack{
                                 Text("Subtotal").font(Font(CTFont(.system, size: 14))).bold()
                                 Spacer()
                                 Text("₹\(subTotal)").font(Font(CTFont(.system, size: 14))).bold()
                                 }
                                 .padding(.top, 10)
                                 .padding(.horizontal, 10)
                                 HStack{
                                 VStack(alignment: .leading, spacing: 6){
                                 Image(systemName: "building.columns.circle")
                                 .frame(width: 40, height: 40)
                                 .onTapGesture {
                                 gstInfo = true
                                 }
                                 Image(systemName: "car")
                                 .frame(width: 40, height: 40)
                                 Spacer()
                                 }
                                 VStack(alignment: .leading, spacing: 6){
                                 Text("Gst \(String(format: "%.2f", gst))% ⓘ").font(Font(CTFont(.system, size: 12)))
                                 .onTapGesture {
                                 gstInfo = true
                                 }
                                 Text("Restaurant delivery fee for \(String(format: "%.2f", distance)) km").font(Font(CTFont(.system, size: 12)))
                                 Text("See how this is calculated \(showDeliveryInfo ? "▲" : "▼")")
                                 .font(Font(CTFont(.system, size: 12)))
                                 .onTapGesture {
                                 showDeliveryInfo = !showDeliveryInfo
                                 }
                                 
                                 }
                                 Spacer()
                                 VStack(alignment: .trailing, spacing: 6){
                                 Text("₹\(String(format: "%.2f", (gst * Double(subTotal) / 100).roundTo() ))")
                                 .font(Font(CTFont(.system, size: 12)))
                                 Text("₹\(String(format: "%.2f", (distance * 5) ))").font(Font(CTFont(.system, size: 12)))
                                 Spacer()
                                 }
                                 
                                 }
                                 //
                                 .padding(.horizontal, 10)
                                 
                                 .alert(isPresented: $gstInfo){
                                 Alert(title: Text("GST INFO"), message: Text("Our App has no role to play in taxes being levied by govt and restaurants"), dismissButton: .default(Text("Got It!")))
                                 }
                                 VStack{
                                 VStack{
                                 HStack{
                                 Text("Base Fee")
                                 Spacer()
                                 Text("40")
                                 }
                                 }
                                 }.isHidden(showDeliveryInfo ? false : true)
                                 */
                                HStack{
                                    Text("Subtotal").font(Font(CTFont(.system, size: 16))).bold()
                                    Spacer()
                                    Text("₹\(subTotal)").font(Font(CTFont(.system, size: 16))).bold()
                                }.padding(.top, 6)
                                    .padding(.horizontal, 10)
                                HStack{
                                    Image(systemName: "building.columns.circle")
                                        .frame(width: 20, height: 20)
                                        .onTapGesture {
                                            gstInfo = true
                                        }
                                    Text("Gst \(String(format: "%.2f", gst))% ⓘ").font(Font(CTFont(.system, size: 12)))
                                        .onTapGesture {
                                            gstInfo = true
                                        }
                                    Spacer()
                                    Text("₹\(String(format: "%.2f", (gst * Double(subTotal) / 100).roundTo() ))")
                                        .font(Font(CTFont(.system, size: 12)))
                                    
                                        .alert(isPresented: $gstInfo){
                                            Alert(title: Text("GST INFO"), message: Text("Our App has no role to play in taxes being levied by govt and restaurants"), dismissButton: .default(Text("Got It!")))
                                        }
                                }
                                .padding(.horizontal, 10)
                                HStack{
                                    Image(systemName: "car")
                                        .frame(width: 20, height: 20)
                                    
                                    Text("Delivery partner fee for \(String(format: "%.2f", distance)) km").font(Font(CTFont(.system, size: 12)))
                                        .onTapGesture(perform: {
                                            gst = gst + 2
                                            distance = distance + 2
                                            
                                        })
                                    Spacer()
                                    Text("₹\(String(format: "%.2f", (distance <= 5.0 ? 40.0 : 40.0 + (distance - 5) * 5 ) ))").font(Font(CTFont(.system, size: 12)))
                                    /*
                                     
                                     */
                                    
                                }
                                .padding(.horizontal, 10)
                                HStack{
                                    Text("fully goes to them for their time and effort")
                                        .font(Font(CTFont(.system, size: 10)))
                                        .padding(.horizontal, 6)
                                        .foregroundColor(Color("DarkGrey"))
                                }
                                .padding(.horizontal, 6)
                                //.padding(.horizontal, 10)
                                .padding(.leading, 20 + 10)
                                VStack{
                                    Text("See how this is calculated \(showDeliveryInfo ? "▲" : "▼")")
                                        .font(Font(CTFont(.system, size: 12)))
                                        //.padding(.horizontal, 6)
                                }
                                .onTapGesture {
                                    withAnimation(.linear, {
                                        showDeliveryInfo = !showDeliveryInfo
                                    })
                                    
                                }
                                .padding(.all, 6)
                                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("Dark"), lineWidth:1))
                                    
                                    .background(Color("LightDark"))
                                    .cornerRadius(6)
                                    .padding(.horizontal, 10)
                                    .padding(.leading, 20 + 10)
                                if(showDeliveryInfo){
                                    VStack(spacing: 6){
                                        HStack{
                                            Text("Base Fee")
                                                .font(Font(CTFont(.system, size: 12)))
                                            Spacer()
                                            Text("₹40")
                                                .font(Font(CTFont(.system, size: 12)))
                                        }
                                        //.padding(.top, 6)
                                            //.padding(.horizontal, 6)
                                        if(distance > 5){
                                            HStack{
                                                Text("Long Distance Fee")
                                                    .font(Font(CTFont(.system, size: 12)))
                                                Spacer()
                                                Text("₹\(String(format: "%.2f",(distance <= 5.0 ? 0 : (distance - 5.0) * 5)) ) ")
                                                    .font(Font(CTFont(.system, size: 12)))
                                            }
                                            HStack{
                                                Text("charget from 5km ownwards")
                                                    .font(Font(CTFont(.system, size: 10)))
                                                //.padding(.horizontal, 6)
                                                    .foregroundColor(Color("DarkGrey"))
                                                Spacer()
                                            }
                                        }
                                        //.padding(6)
                                        
                                        
                                    }
                                    .padding(.all, 6)
                                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("Dark"), lineWidth:1))
                                    .background(Color("LightDark"))
                                    .cornerRadius(6)
                                    
                                    .padding(.horizontal, 10)
                                    .padding(.leading, 20 + 10)

                                    
                                    
                                    
                                }
                                // grand
                                VStack{
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 1)
                                .background(Color("Dark"))
                                .cornerRadius(20)
                                .padding(.horizontal, 10)
                                HStack{
                                    VStack(alignment: .leading, spacing: 10){
                                        Text("Grand Total").font(Font(CTFont(.system, size: 16))).bold()
                                    }
                                    .padding(.bottom, 10)
                                    .padding(.horizontal, 10)
                                    Spacer()
                                    VStack(alignment: .trailing, spacing: 10){
                                        Text("₹\(String(format: "%.2f", (Double(subTotal) * gst / 100).roundTo() + Double(subTotal) + (distance <= 5.0 ? 40.0 : 40.0 + (distance - 5) * 5 ) ))").font(Font(CTFont(.system, size: 16))).bold()
                                    }
                                    .padding(.bottom, 10)
                                    .padding(.horizontal, 10)
                                    
                                    
                                }
                                
                            }.background(Color("Light"))
                                .cornerRadius(10)
                            ////Cancellation
                            Separator(text: "PROFILE")
                            HStack{
                                VStack(alignment: .leading, spacing: 6){
                                    Text("Your Details")
                                        .font(Font(CTFont(.system, size: 12))).bold()
                                        
                                    Text("TADA")
                                        .font(Font(CTFont(.system, size: 12)))
                                        
                                        
                                }.padding(.all, 10)
                                Spacer()
                                VStack{
                                    Text(">")
                                        .font(Font(CTFont(.system, size: 18)))
                                }.padding(.all, 10)
                                
                                
                            }.frame(maxWidth: .infinity)
                                .background(Color("Light"))
                                .cornerRadius(10)
                            
                            
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
                        
                        
                        LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 8)
                        
                        HStack{
                            Image(systemName: "location.circle").foregroundColor(Color("Dark"))
                            Text("Delivery at **\(location)**").font(Font(CTFont(.system, size: 14)))
                            Spacer()
                            Text("Change")
                                .foregroundColor(.red)
                                .font(Font(CTFont(.system, size: 14)))
                        }
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                        .padding(.bottom, 4)
                        VStack{
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .background(Color("Dark"))
                        .cornerRadius(20)
                        HStack{
                            
                            
                            Menu(content: {
                                Button("COD", action: {
                                    paymentMode = .cash
                                })
                                Button("UPI", action: {
                                    paymentMode = .upi
                                })
                            }, label: {
                                VStack(alignment: .leading, spacing: 6){
                                    HStack{
                                        Image(systemName: "indianrupeesign.square.fill").foregroundColor(Color("Dark"))
                                        Text("PAY USING ▲").font(Font(CTFont(.system, size: 12)))
                                    }
                                    Text(paymentMode == .cash ? "Cash on Delivery" : "UPI").font(Font(CTFont(.system, size: 14)))
                                }
                                .foregroundColor(.black)
                                
                            }
                                 
                            ).padding(.vertical, 4)
                            Spacer()
                            
                            HStack{
                                VStack(alignment: .leading){
                                    Text("₹\(String(format: "%.2f", (Double(subTotal) * gst / 100).roundTo() + Double(subTotal) + (distance <= 5.0 ? 40.0 : 40.0 + (distance - 5) * 5 ) ))")
                                        .font(Font(CTFont(.system, size: 14))).foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                        //.frame(width: 80)
                                        
                                        //.frame(width: 80)
                                        //.background(.black)
                                        
                                    Text("Total").font(Font(CTFont(.system, size: 12)))
                                        .foregroundColor(.white)
                                        
                                }.padding(10)
                                    .frame(width: 100)
                                    
                                Spacer()
                                VStack{
                                    Text("Place Order ►").foregroundColor(.white)
                                }.padding(10)
                            }
                            
                            .background(Color("Dark"))
                            .cornerRadius(10)
                            .fixedSize()
                            //.padding(.leading, 16)
                            /*
                            CustomPrimaryButton(title: "Select Address at next step ►", height: 40, colorr: Color("Dark"), borderColor: Color("Dark"), textColor: Color(.black), closure: {
                                
                            })
                             */
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .padding(.bottom, 10)
                    }
                    //.frame(height: 40)Image(systemName: "cart.badge.questionmark.ar")
                    .background(Color("Light"))
                    .upperCurve(10, corners: [.topLeft, .topRight])
                    
                }
            }
            else{
                VStack{
                    VStack{
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .frame(height: 64, alignment: .top)
                    .overlay(CustomNavigation(title: "Cart" , ONPAGE: $ONPAGE, leftImage: "location.north.circle.fill"))
                    Spacer()
                    Image(systemName: "cart.fill.badge.questionmark.rtl").resizable().scaledToFit()
                        .minimumScaleFactor(2)
                        
                        .frame(width: 200, height: 200)
                        .fixedSize()
                    Text("Cart is Empty :/")
                    Spacer()
                }.frame(maxHeight: .infinity)
            }
            
            
        }
        .animation(.easeInOut(duration: 0.1))
        .onAppear(){
            calcSubTotal()
            print(cartItems.count)
            
        }
        
        
    }
    func calcTotal(){
        gstAmt = Double(subTotal) * gst / 100
        
        grandTotal = Double(subTotal) + gstAmt
        grandTotal = grandTotal + distance * 5
        //(Double(subTotal) * gst / 100) + Double(subTotal) + distance * 5
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

extension View{
    func upperCurve(_ radius: CGFloat, corners: UIRectCorner) -> some View{
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

extension Double{
    func roundTo(_ places:Int = 2) -> Double{
        var starting = Int(self)
        var decimal = self - Double(starting)
        decimal = decimal * 100
        var decdigit = Int(decimal)
        var finalans = Double(starting) + Double(decdigit) / 100
        //print(self, finalans)
        return finalans
    }
}

struct RoundedCorner:Shape{
    var radius:CGFloat = . infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path{
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
