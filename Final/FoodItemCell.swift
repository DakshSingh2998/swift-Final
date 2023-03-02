//
//  FoodItemCell.swift
//  Final
//
//  Created by Daksh on 01/03/23.
//

import SwiftUI

struct FoodItemCell: View {
    @State var bgImage = "Pizza"
    @State var height = CGFloat(100)
    @State var loved = false
    @State var loveScale = 1.0
    @State var loveAnimationScale = 1.0
    @State var loveAnimationHidden = true
    @State var animationRotation = 0.0
    var body: some View {
        VStack(spacing: 0){
            ZStack(alignment: .bottom){
                Image(bgImage)
                    .resizable()
                    
                    .scaledToFill()
                    .frame(height: height - 24)
                    //.frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    .padding(.all ,0)
                    .clipped()
                    
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .bottom, endPoint: .top)
                    .frame(height: 64)
                VStack{
                    HStack(alignment: .bottom){
                        
                        HStack{
                            Text("Margherita•")
                            Text("149")
                        }
                        .padding(2)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.7))
                        .font(Font(CTFont(.system, size: 14)))
                        //.overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.black, lineWidth:2))
                        .cornerRadius(6)
                        
                        
                        
                        Spacer()
                        ZStack{
                            Image("Animation").resizable()
                                .frame(width: 20, height: 18)
                                .cornerRadius(9)
                                .scaleEffect(loveAnimationScale)
                                //.animation(.linear(duration: 0.4), value: loveAnimationScale)
                                .rotationEffect(.degrees(animationRotation))
                                .isHidden(loveAnimationHidden)
                            
                            
                            Image(systemName: "suit.heart.fill")
                                .resizable()
                            //.shadow(radius: 6)
                            
                                .foregroundColor(loved ? Color.pink.opacity(0.9) : Color.black.opacity(0.9))
                                .frame(width: 20, height: 18)
                                .overlay(Image(systemName: "suit.heart")
                                    .resizable()
                                    .frame(width: 20, height: 18)
                                    .foregroundColor(Color.white))
                                .scaleEffect(loveScale)
                                .animation(.linear(duration: 0.2))
                                .onTapGesture(){
                                    if(loved){
                                        loveScale = 0.7
                                    }
                                    else{
                                        
                                        loveAnimationHidden = false
                                        
                                        loveScale = 1.3
                                        withAnimation(.linear(duration: 0.2)){
                                            loveAnimationScale = 2.5
                                            //animationRotation = -90.0
                                        }
                                        
                                    }
                                    loved.toggle()
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                        withAnimation(.linear(duration: 0.1)){
                                            loveAnimationHidden = true
                                        }
                                        animationRotation = 0.0
                                        loveAnimationScale = 1.0
                                        loveScale = 1.0
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                            
                                        }
                                        
                                        
                                    }
                                }
                        }
                        .padding(.trailing, 6)
                            //.frame(width: 48, height: 48)
                            
                    }
                    .padding(.top, 16)
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
                        }.bold()
                            .background(Color("Green"))
                            .cornerRadius(4)
                        }.foregroundColor(.white)
                    
                }.padding(6)
                    

            }
            .background(.white)
            //.shadow(radius: 0)
            //.frame(height: 140)
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack{
                Image(systemName: "deskclock.fill").frame(width: 20, height: 20)
                    .foregroundColor(Color("Green"))
                Text("20-25 min • ")
                Text("1 km")
                Spacer()
                Text("150 for one")
            }.font(Font(CTFont(.system, size: 14)))
                .padding(.all, 6)
                .padding(.bottom, 4)
                //.shadow(radius: 0)
                .background(.white)
                //.frame(height: 24)
            //.padding(.horizontal, 10)
            
            
            
        }
        //.padding(6)
        //.background(Color.black.opacity(0.8))
        .frame(height: height)
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        //.shadow(radius: 20)
        .background(.white)
        
        .cornerRadius(10)
        
    }
}

struct FoodItemCell_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemCell()
    }
}
