//
//  FoodItemCell.swift
//  Final
//
//  Created by Daksh on 01/03/23.
//

import SwiftUI

struct FoodItemCell: View {
    @State var bgImage = "LaunchScreenImage"
    var body: some View {
        VStack(spacing: 0){
            ZStack(alignment: .bottom){
                Image(bgImage).resizable().scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.all ,0)
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .bottom, endPoint: .top)
                    .frame(height: 64)
                VStack{
                    HStack{
                        
                        HStack{
                            Text("Margherita•")
                            Text("149")
                        }
                        .padding(2)
                        .foregroundColor(.white)
                            .background(Color.black.opacity(0.6))
                            .font(Font(CTFont(.system, size: 14)))
                            .cornerRadius(6)
                            
                        
                        
                        Spacer()
                        Image(systemName: "suit.heart")
                            .shadow(radius: 6)
                            .frame(width: 32, height: 32)
                            .foregroundColor(Color("Dark"))
                            
                    }
                    Spacer()
                    HStack(alignment: .bottom){
                        
                            
                            VStack(alignment: .leading){
                                Text("Res Name").font(Font(CTFont(.system, size: 24))).bold()
                                    
                                Text("Pizza • Pasta").font(Font(CTFont(.system, size: 14)))
                                    
                            }
                            Spacer()
                        HStack(spacing: 0){
                                Text("3.5").font(Font(CTFont(.system, size: 14)))
                                    .padding(.top, 2)
                                    .padding(.leading, 2)
                                    .padding(.bottom, 2)
                                Text("★").font(Font(CTFont(.system, size: 10)))
                                    .padding(.top, 2)
                                    .padding(.trailing, 2)
                                    .padding(.bottom, 2)
                            }
                            .background(Color("Green"))
                            .cornerRadius(4)
                        }.foregroundColor(.white)
                    
                }.padding(6)
                    

            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack{
                Image(systemName: "deskclock.fill").frame(width: 20, height: 20)
                    .foregroundColor(Color("Green"))
                Text("20-25 min • ")
                Text("1 km")
                Spacer()
                Text("150 for one")
            }.font(Font(CTFont(.system, size: 14)))
            //.padding(.horizontal, 10)
            .padding(.all, 10)
            
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .cornerRadius(10)
    }
}

struct FoodItemCell_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemCell()
    }
}
