//
//  RestaurantHomePage.swift
//  Final
//
//  Created by Daksh on 06/03/23.
//

import SwiftUI
struct ContentData: Identifiable{
    @State var id = UUID()
    @State var name = ""
    @State var isOpen = true
    @State var idx = 0
}
struct Dish: Identifiable{
    @State var id = UUID()
    @State var name = ""
    @State var idx = 0
}
struct RestaurantHomePage: View {
    @State var content:[ContentData] = []
    @State var dish:[[Dish]] = []
    @State var location = "Noida sec 68"
    @State var distance = 7
    var body: some View {
        getContentView()
        
        .background(Color("LightGrey"))
        .onAppear(){
            
            content.append(ContentData( name: "Restaurant", idx: 0) )
            content.append(ContentData( name: "Recommended", idx: 0) )
            content.append(ContentData( name: "Combos", idx: 1) )
            content.append(ContentData( name: "Pizzas", idx: 2) )
            content.append(ContentData( name: "Chinese", idx: 3) )
            content.append(ContentData( name: "ABCD", idx: 4) )
            content.append(ContentData( name: "EFGH", idx: 5) )
            content.append(ContentData( name: "IJKL", idx: 6) )
            for i in 0...6{
                var temp:[Dish] = []
                    temp.append(Dish(name: "\(i)A", idx: i))
                temp.append(Dish(name: "\(i)B", idx: i))
                temp.append(Dish(name: "\(i)C", idx: i))
                temp.append(Dish(name: "\(i)D", idx: i))
                dish.append(temp)
            }
             
        }
         
    }
         
    
    private func getContentView() -> some View{
        ZStack{
            //LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            List{
                ForEach(0..<content.count, id: \.self){ idx in
                    VStack{
                        if(idx == 0){
                                heading()
                                .padding(8)
                                .background(Color.white)
                                
                                .cornerRadius(10)
                                .padding(10)
                                
                                
                                .font(Font(CTFont(.system, size: 14)))
                            
                        }
                        else{
                            HStack{
                                Text(content[idx].name).font(Font(CTFont(.system, size: 16))).bold()
                                Spacer()
                                Text(content[idx].isOpen ? "▲" : "▼").onTapGesture(perform: {
                                    
                                    content[idx] = ContentData(id: content[idx].id, name: content[idx].name, isOpen: !content[idx].isOpen)
                                })
                            }
                            //Group{
                                if(content[idx].isOpen){
                                    ForEach(dish[content[idx].idx]){ curDish in
                                        row(cd: curDish)
                                    }
                                }else{
                                    VStack{
                                        Spacer()
                                    }
                                    .frame(height: 1)
                                    
                                }
                                
                            //}
                        }
                    }
                    
                    .padding(6)
                    .background(.white)
                    .cornerRadius(6)
                }
                //.background(.white)
                //.background(Color.white)
                .listRowBackground(Color.clear)
                //.listRowPlatterColor(Color.white)
                .listRowSeparator(.hidden)
                .listSectionSeparator(.hidden)
                
            }
            .listStyle(.plain)
            .padding(.horizontal, -10)
            
        }
    }
    private func row(cd curDish:Dish) -> some View{
        return HStack{
            VStack(alignment: .leading){
                Image(systemName: "dot.square").foregroundColor(Color("Green")).bold()
                Text(curDish.name).font(Font(CTFont(.system, size: 16))).bold()
                HStack{
                    Text("4.5 ★").padding(4)
                        .background(Color("Green"))
                        .cornerRadius(6)
                    Text("29 ratings")
                }
                Text("₹130").bold()
                Text("kjSBfdiuwbrgbwrjgbjwbrkgjwbkjebvgikwbrkgw rgbwkrbgkwb")
                    .lineLimit(5)
                    .multilineTextAlignment(.leading)

            }.font(Font(CTFont(.system, size: 14)))
            Spacer()
            ZStack(alignment: .bottom){
                VStack{
                    Image("Pizza").resizable()
                        .frame(width: 120 ,height: 100)
                        .scaledToFill()
                    
                        .cornerRadius(10)
                    HStack{
                        Spacer()
                    }.frame(height: 20)
                }
                
            }
        }.animation(Animation.easeInOut(duration: 0.2))
        
    }
    func heading() -> some View{
        return HStack{
            VStack(alignment: .leading, spacing: 6){
                Text("Restaurant Name").font(Font(CTFont(.system, size: 20))).bold()
                Text("North India, Chinese")
                Text(location).foregroundColor(Color("Grey"))
                HStack{
                    Image(systemName: "deskclock.fill")
                    Text("\(distance * 5) mins | \(distance) km away")
                }
                
            }
            Spacer()
            VStack(spacing: 0){
                VStack{
                    Text("5.5 ★").font(Font(CTFont(.system, size: 20))).bold()
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                }.background(Color("Green"))
                    .foregroundColor(Color.white)
                    .upperCurve(10, corners: [.topLeft, .topRight])
                VStack{
                    Text("14.3K").bold()
                    Text("Reviews")
                }
            }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Grey"), lineWidth:1))
                .font(Font(CTFont(.system, size: 10)))
            
        }
    }
    
}



/*
struct DishView:View{
    @Binding var dish:[[Dish]]
    @State var idx = -1
    @State var didx = -1
    var body: some View{
 HStack{
     VStack(alignment: .leading){
         Image(systemName: "dot.square").foregroundColor(Color("Green")).bold()
         Text(dish[idx][didx].name).font(Font(CTFont(.system, size: 16))).bold()
         HStack{
             Text("4.5 *").padding(4)
                 .background(Color("Green"))
                 .cornerRadius(6)
             Text("29 ratings")
         }
         Text("₹130").bold()
         Text("kjSBfdiuwbrgbwrjgbjwbrkgjwbkjebvgikwbrkgw rgbwkrbgkwb")
             .lineLimit(5)
             .multilineTextAlignment(.leading)

     }.font(Font(CTFont(.system, size: 14)))
     Spacer()
     VStack{
         Image("Pizza").resizable()
             .frame(width: 120 ,height: 100)
             .scaledToFill()

             .cornerRadius(10)
     }
 }
    }
}
*/
struct RestaurantHomePage_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantHomePage()
    }
}
