//
//  GroceryMenu.swift
//  Final
//
//  Created by Daksh on 21/02/23.
//

import SwiftUI

struct GroceryMenu: View {
    @State var installButtonScale = 1.0
    
    var coloredSignIn: AttributedString{
        var result = AttributedString("WELCOME100")
        result.foregroundColor = Color("Green")
        //result.font = .boldSystemFont(ofSize: 18)
        return result
    }
    
    var body: some View {
        
        ScrollView{
            VStack{
                Text("Groceries in minutes!").font(Font(CTFont(.system, size: 32))).fontWeight(.bold)
                Image("GroceryImage1")
                VStack(spacing: 15){
                    Image("BlinkitLogo").resizable().scaledToFit().frame(width: 100).padding(.top, 30)
                    
                    Text("India's Last Minute App").font(Font(CTFont(.system, size: 24))).fontWeight(.bold)
                        .padding(.top, 15)
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
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("Green"), lineWidth:2))
                .background(Color("GroceryYellow"))
                
                .cornerRadius(20)
                .shadow(radius: 50)
                .padding(.horizontal, 20)
                Text("★ ENJOY THESE BENEFITS ★").font(Font.custom("Courier New", size: 18)).fontWeight(.bold).padding(.top, 40)
                GroceryList(image: "GroceryImage2", text: "Enjoy 5000+ products to suit your needs")
                    .padding(.horizontal, 15).padding(.top, 16)
                GroceryList(image: "GroceryImage2", text: "Everything delivered in minutes")
                    .padding(.horizontal, 15).padding(.top, 8)
                GroceryList(image: "GroceryImage2", text: "Amazing payments and bank offers")
                    .padding(.horizontal, 15).padding(.top, 8)
                    .padding(.bottom, 16)
            }.shadow(radius: 20)
            
        }
        
    }
}

struct GroceryList: View{
    @State var image:String?
    @State var text:String?
    var body: some View{
        HStack(alignment: .center){
            //VStack(alignment: .leading){
                Image(image ?? "Logo").resizable().scaledToFit().frame(width: 50, height: 50)
                    .cornerRadius(100)
                    .background(Color("GroceryYellow"))
                    .cornerRadius(100).padding(.leading, 15)
            //}
            //.frame(maxWidth: .infinity)
            
            
            Text(text ?? "").font(Font.custom("Courier New", size: 16)).fontWeight(.bold).multilineTextAlignment(.leading)
            Spacer()
        }
        .frame(height: 70)
        .frame(maxWidth: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("Grey"), lineWidth:2))
        //.background(Color("GroceryYellow"))
        .cornerRadius(20)
        
    }
}
struct GroceryMenu_Previews: PreviewProvider {
    static var previews: some View {
        GroceryMenu()
    }
}
