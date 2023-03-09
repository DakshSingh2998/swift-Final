
import SwiftUI

struct FoodItemCell: View {
    @Binding var restaurantModel:[RestaurantModel]
    @Binding var showRestaurantModel:RestaurantModel
    //= RestaurantModel(isVeg: true, category: 0, price: 0, isLiked: true, id: 0, location: "", rating: "", name: "")
    @State var idx = -1
    @State var bgImage = "Pizza"
    @State var height = CGFloat(100)
    @State var loveScale = 1.0
    @State var loveAnimationScale = 1.0
    @State var loveAnimationHidden = true
    @State var animationRotation = 0.0
    var body: some View {
        VStack(spacing: 6){
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
                            Text("\(showRestaurantModel.price!)")
                        }
                        .padding(2)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.7))
                        .font(Font(CTFont(.system, size: 14)))
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("DarkGrey"), lineWidth:2))
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
                            
                                .foregroundColor(showRestaurantModel.isLiked! ? Color.pink.opacity(0.9) : Color.black.opacity(0.9))
                                .frame(width: 20, height: 18)
                                .overlay(Image(systemName: "suit.heart")
                                    .resizable()
                                    .frame(width: 20, height: 18)
                                    .foregroundColor(Color.white))
                                .scaleEffect(loveScale)
                                .animation(.linear(duration: 0.2))
                                .onTapGesture(){
                                    if(showRestaurantModel.isLiked!){
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
                                    restaurantModel[idx] = RestaurantModel(isVeg: restaurantModel[idx].isVeg, category: restaurantModel[idx].category, price: restaurantModel[idx].price, isLiked: !restaurantModel[idx].isLiked!, id: restaurantModel[idx].id, location: restaurantModel[idx].location, rating: restaurantModel[idx].rating, name:restaurantModel[idx].name)
                                    
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
                                Text(showRestaurantModel.name!).font(Font(CTFont(.system, size: 24))).bold()
                                    
                                Text("Pizza • Pasta").font(Font(CTFont(.system, size: 14)))
                                    
                            }
                            Spacer()
                        HStack(spacing: 0){
                            Text("\(showRestaurantModel.rating!)").font(Font(CTFont(.system, size: 14)))
                                .padding(.all, 2)
                                //Text("★").font(Font(CTFont(.system, size: 10)))
                                //.padding(.all, 2)
                        }.bold()
                            .padding(.horizontal, 2)
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
                Text("\(showRestaurantModel.category! * 5 )-\(showRestaurantModel.category! * 5 + 5) min • ")
                Text("\(showRestaurantModel.category!) km")
                Spacer()
                Text("\(showRestaurantModel.price!) for one")
            }.font(Font(CTFont(.system, size: 14)))
                .padding(.all, 6)
                .padding(.bottom, 8)
                .padding(.top, -6)
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
/*
struct FoodItemCell_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemCell()
    }
}
*/
