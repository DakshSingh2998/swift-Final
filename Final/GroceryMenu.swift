//
//  GroceryMenu.swift
//  Final
//
//  Created by Daksh on 21/02/23.
//

import SwiftUI
struct GroceryListData: Identifiable{
    var id = UUID()
    
    @State var image = ""
    @State var description = ""
}

struct GroceryMenu: View {
    @State var installButtonScale = 1.0
    @State var groceryData:[GroceryListData] = []
    var coloredSignIn: AttributedString{
        var result = AttributedString("WELCOME100")
        result.foregroundColor = Color("Green")
        //result.font = .boldSystemFont(ofSize: 18)
        return result
    }
    @State var seen = true
    @Binding var ONPAGE:Double
    
    func addDummyData(){
        groceryData = []
        groceryData.append(GroceryListData(image: "GroceryImage2", description: "Enjoy 5000+ products to suit your needs"))
        groceryData.append(GroceryListData(image: "GroceryImage2", description: "Everything delivered in minutes"))
        groceryData.append(GroceryListData(image: "GroceryImage2", description: "Amazing payments and bank offers"))
    }
    
    var body: some View {
        ZStack(alignment: .top){
            CustomNavigation(title: "Grocery" , ONPAGE: $ONPAGE, leftImage: "location.north.circle.fill")
                .frame(height: 64)
            VStack(spacing: 0){
                
                ScrollView{
                    if(seen){
                        VStack{
                            Text("Groceries in minutes!").font(Font(CTFont(.system, size: 32))).fontWeight(.bold)
                            Image("GroceryImage1").resizable().scaledToFit().frame(maxWidth: .infinity)
                                .padding(.horizontal, 0)
                            VStack(spacing: 10){
                                Image("BlinkitLogo").resizable().scaledToFit().frame(width: 75).padding(.top, 16)
                                
                                Text("India's Last Minute App").font(Font(CTFont(.system, size: 24))).fontWeight(.bold)
                                    .padding(.top, 8)
                                Text("Get **₹100 OFF** & **free delivery**").font(Font(CTFont(.system, size: 20)))
                                Text("Use Code " + coloredSignIn +  " on your first order").font(Font(CTFont(.system, size: 14)))
                                    .padding(.bottom, 15)
                                //button
                                CustomPrimaryButton(title: "Install Blinkit Now", colorr: Color("Green")){
                                    installButtonScale = 1.2
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                                        self.installButtonScale = 1.0
                                    }
                                }.scaleEffect(installButtonScale)
                                    .animation(.linear(duration: 0.2))
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 30)
                                
                            }
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("GroceryBorder"), lineWidth:2))
                            .background(Color("GroceryYellow"))
                            
                            .cornerRadius(20)
                            //.shadow(radius: 50)
                            .padding(.horizontal, 20)
                            .padding(.top, 0)
                            
                            
                            Text("★ ENJOY THESE BENEFITS ★")
                                .font(Font.custom("Courier New", size: 18))
                                .fontWeight(.bold).padding(.top, 16)
                            VStack(spacing: 20){
                                ForEach(groceryData) { datum in
                                    GroceryList(image: datum.image, text: datum.description)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                            VStack{
                                LinearGradient(colors: [Color("LightGrey"), .white], startPoint: .top, endPoint: .bottom)
                                    .ignoresSafeArea()
                            }
                            .frame(maxWidth: .infinity, minHeight: 20)
                            .ignoresSafeArea()
                        }
                    }
                }
            }.padding(.top, 64)
            .frame(maxHeight: .infinity)
        }
        .frame(maxHeight: .infinity)
        .onAppear(){
            addDummyData()
            print("Grocery onAppear")
            //seen = true
        }
        .onDisappear(){
            //seen = false
        }
        .refreshable {
            addDummyData()
        }
    }
}

struct GroceryList: View{
    @State var image:String?
    @State var text:String?
    var body: some View{
        HStack(alignment: .center){
            //VStack(alignment: .leading){
                Image(image ?? "Logo").resizable().scaledToFit().frame(width: 75, height: 75)
                    .cornerRadius(100)
                    .background(Color("GroceryYellow"))
                    .cornerRadius(100)
                    .padding(.leading, 15)
            //}
            //.frame(maxWidth: .infinity)
            
            
            Text(text ?? "").font(Font.custom("Courier New", size: 18)).fontWeight(.bold).multilineTextAlignment(.leading)
            Spacer()
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("Grey"), lineWidth:2))
        //.background(Color("GroceryYellow"))
        .cornerRadius(20)
        
    }
}
/*
struct GroceryMenu_Previews: PreviewProvider {
    static var previews: some View {
        GroceryMenu()
    }
}

*/
