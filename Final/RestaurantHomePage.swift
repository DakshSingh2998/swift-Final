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
    @State var offset = CGFloat.zero
}
struct Dish: Identifiable{
    @State var id = UUID()
    @State var name = ""
    @State var idx = 0
    @State var childIdx = 0
    
}
struct RestaurantHomePage: View {
    @State var content:[ContentData] = []
    @State var dish:[[Dish]] = []
    @State var location = "Noida sec 68"
    @State var distance = 7
    @State var offset = CGFloat.zero
    @State var descArray:[String] = []
    @State var dishModel:[DishModel] = []
    @State var dishModel2d:[[DishModel]] = []
    @Binding var restuarantDishUrl:String
    var body: some View {
        getContentView()
        
        .background(Color("LightGrey"))
        .onAppear(){
            
            NetworkManager.shared.getApi(url: self.restuarantDishUrl){
                data in
                guard let data = data as? [[String: Any]] else {return}
                var values:[[String: Any]] = []
                for i in 0..<20{
                    values.append(data[i])
                }
                //print(values)
                self.dishModel = values.map{DishModel(data: $0)}
                var k = 0
                
                for i in 0...5{
                    var temp:[DishModel] = []
                    for j in 0...2{
                        temp.append(self.dishModel[k])
                        k = k + 1
                    }
                    self.dishModel2d.append(temp)
                }
                var temp:[DishModel] = []
                while(k < dishModel.count){
                    temp.append(self.dishModel[k])
                    k = k + 1
                }
                self.dishModel2d.append(temp)
                
                //print(dishModel)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.content.append(ContentData( name: "Restaurant", idx: 0) )
                self.content.append(ContentData( name: "Recommended", idx: 0) )
                self.content.append(ContentData( name: "Combos", idx: 1) )
                self.content.append(ContentData( name: "Pizzas", idx: 2) )
                self.content.append(ContentData( name: "Chinese", idx: 3) )
                self.content.append(ContentData( name: "ABCD", idx: 4) )
                self.content.append(ContentData( name: "EFGH", idx: 5) )
                self.content.append(ContentData( name: "IJKL", idx: 6) )
                //print(self.dishModel2d)
            })
            
            
             
        }
         
    }
         
    
    private func getContentView() -> some View{
        ZStack{
            //LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            VStack{
                HStack{
                    Text((descArray.count - 1) >= 0 ? descArray[descArray.count - 1] : "Restaurant Name" )
                    Spacer()
                }.frame(maxWidth: .infinity)
                    .background(Color.white)
                List{
                    ForEach(0..<content.count, id: \.self){ idx in
                        VStack{
                            if(idx == 0){
                                heading()
                                    .font(Font(CTFont(.system, size: 14)))
                                
                            }
                            else{
                                HStack{
                                    Text(content[idx].name).font(Font(CTFont(.system, size: 16))).bold()
                                    Spacer()
                                    Text(content[idx].isOpen ? "▲" : "▼").onTapGesture(perform: {
                                        
                                        content[idx] = ContentData(id: content[idx].id, name: content[idx].name, isOpen: !content[idx].isOpen, idx: content[idx].idx, offset: content[idx].offset)
                                    })
                                }
                                .onTapGesture(perform: {
                                    print(content[idx].offset)
                                })
                                .background(GeometryReader{ proxy -> Color in
                                    DispatchQueue.main.async{
                                        content[idx] = ContentData(id: content[idx].id, name: content[idx].name, isOpen: content[idx].isOpen, idx: content[idx].idx, offset: proxy.frame(in: .named("scroll")).origin.y)
                                        //print(idx, content[idx].offset)
                                        
                                        if(content[idx].offset < 110 && content[idx].offset > 0 && idx >= 1){
                                            if((idx - 1) == descArray.count){
                                                descArray.append(content[idx].name)
                                            }
                                            
                                        }
                                        else if(content[idx].offset > 80 && idx >= 1){
                                            if(descArray.count <= 0){
                                                
                                            }
                                            else if(descArray[descArray.count - 1] == content[idx].name){
                                                descArray.remove(at: descArray.count - 1)
                                            }
                                         
                                        }
                                        
                                    }
                                    return Color.white
                                })
                                
                                
                                //Group{
                                
                                if(content[idx].isOpen){
                                    
                                    ForEach(dishModel2d[content[idx].idx]){ curDish in
                                        
                                        row(cd: curDish)
                                        
                                        if(0 < 1){
                                            Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                                .frame( height: 1)
                                                .foregroundColor(Color("DarkGrey"))
                                                .padding(.vertical, 8)
                                                .padding(.bottom, 6)
                                        }
                                        else{
                                            VStack{
                                                
                                            }.frame(height: 1)
                                                .frame(maxWidth: .infinity)
                                                .background(Color.white)
                                        }
                                        
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
                        
                        .padding(10)
                        .background(idx == 0 ? Color("LightGrey") : Color.white)
                        .cornerRadius(6)
                        .padding(.vertical, 10)
                    }
                    //.background(.white)
                    //.background(Color.white)
                    .listRowBackground(Color.clear)
                    //.listRowPlatterColor(Color.white)
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                    
                }
                
                .coordinateSpace(name: "scroll")
                
                .listStyle(.plain)
                .padding(.horizontal, -20)
            }
        }
    }
    private func row(cd curDish:DishModel) -> some View{
        return HStack{
            VStack(alignment: .leading, spacing: 10){
                Image(systemName: "dot.square").foregroundColor(curDish.isVeg! ? Color("Green") : Color.red).bold()
                Text(curDish.name!).font(Font(CTFont(.system, size: 16))).bold()
                HStack{
                    Text(curDish.rating!).padding(4)
                        .background(Color("Green"))
                        .cornerRadius(6)
                    Text("\(curDish.votes!) votes")
                }
                Text("₹\(curDish.price!)").bold()
                Text(curDish.description!)
                    .foregroundColor(Color("DarkGrey"))
                    .lineLimit(5)
                    .multilineTextAlignment(.leading)

            }.font(Font(CTFont(.system, size: 14)))
            Spacer()
            ZStack(alignment: .bottomTrailing){
                VStack(alignment: .trailing){
                    Spacer()
                    
                    AsyncImage(url: URL(string: curDish.imageUrl!)!,
                                  placeholder: { Text("Loading ...") },
                                  image: { Image(uiImage: $0).resizable() })
                        .frame(width: 140 ,height: 140)
                        .scaledToFill()
                    
                        .cornerRadius(10)
                    
                    HStack{
                        Spacer()
                    }.frame(height: 10)
                     
                }.frame(maxHeight: .infinity)
                VStack(spacing: -8){
                    HStack{
                        Spacer()
                        Text("+").frame(alignment: .topTrailing).font(Font(CTFont(.system, size: 12))).bold()
                            .padding(.trailing, 6)
                    }
                    
                    Text("ADD").bold()
                        .padding(.bottom, 6)
                    
                }.frame(width: 100, height: 32)
                .background(Color("Light"))
                .foregroundColor(Color("Dark"))
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("Dark"), lineWidth: 2))
                .cornerRadius(6)
                .padding(.trailing, 20)
                
            }.frame(maxHeight: .infinity)
        }
        //.animation(Animation.easeInOut(duration: 0.2))
        
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
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
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
struct ViewOffsetKey: PreferenceKey{
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
struct Line: Shape{
    func path(in rect: CGRect) -> Path{
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
/*
 struct RestaurantHomePage_Previews: PreviewProvider {
 static var previews: some View {
 RestaurantHomePage()
 }
 }
 */
