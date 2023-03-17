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
    @Environment(\.dismiss) var dismiss
    @State var content:[ContentData] = []
    @State var dish:[[Dish]] = []
    @State var distance = 7
    @State var offset = CGFloat.zero
    @State var descArray:[String] = []
    @State var dishModel:[DishModel] = []
    @State var dishModel2d:[[DishModel]] = []
    @Binding var restuarantDishUrl:String
    @State var restaurantModel:RestaurantModel
    @State var imageForDish:[DishModel:Image] = [:]
    @State var offsets:[Double] = []
    @State var filterCategory:[FilterCategory]
    @Binding var cartItems:[Food]
    @Binding var userData:UserData?
    @State var dishQuantity:[DishModel: Int] = [:]
    @State var dummySubtotal = 0
    @State var showRemove = false
    @State var showRemoveCurDish:DishModel?
    @State var apiLoaded = false
    @Binding var onPage:Int
    var body: some View {
        ZStack(alignment: .bottom){
            if(apiLoaded == true){
                getContentView().padding(.bottom, cartItems.count == 0 || cartItems[0].restaurantName != restaurantModel.name! ? 0 : 60)
                if(cartItems.count != 0 && cartItems[0].restaurantName == restaurantModel.name!){
                    HStack{
                        Text("\(cartItems.count) ITEM(s) ADDED").font(Font(CTFont(.system, size: 14)))
                            .fixedSize()
                            .padding(10)
                            Spacer()
                        CustomPrimaryButton(title: "Next", height: 40, colorr: Color("Dark"), borderColor: Color("Dark"), textColor: Color.white, closure: {
                            try? dismiss()
                            onPage = 3
                        })
                        .frame(width: 200)
                        .fixedSize()
                        .padding(10)
                    }
                    //.padding(20)
                    //.background(Color("White"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    
                }
                else{
                    VStack{
                        Spacer()
                    }
                    .frame(height: 1)
                    .background(Color.clear)
                }
                
            }
            else{
                ProgressView("Ready to Eat?")
                    .background(Color.white)
            }
            
        }
        
        
        .background(Color("LightGrey"))
        .onAppear(){
            
            NetworkManager.shared.getApi(url: self.restuarantDishUrl){
                data in
                guard let data = data as? [[String: Any]] else {return}
                var values:[[String: Any]] = []
                for i in 0..<20{
                    values.append(data[i])
                }
                self.dishModel = values.map{DishModel(data: $0)}
                for curDish in self.dishModel{
                    dishQuantity[curDish] = 0
                }
                apiLoaded = true    
                // load image
                
                for curDish in self.dishModel {
                    let url = URL(string: curDish.imageUrl!)!
                        // Fetch Image Data
                    let dataTask = URLSession.shared.dataTask(with: url) { [self] (data, response, err) in
                        if data != nil {
                            do{
                                let tempImage = try? UIImage(data: data!)
                                let image = try? Image(uiImage: tempImage!)
                                try? self.imageForDish[curDish] = image
                                
                            }
                            catch{
                                print("\(err) \(curDish)")
                            }
                        }
                    }
                    dataTask.resume()
                }

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
                /////////////////////////////////// load category
                self.content.append(ContentData( name: restaurantModel.name!, idx: 0) )
                self.content.append(ContentData( name: "Recommended", idx: 0) )
                self.content.append(ContentData( name: "Combos", idx: 1) )
                self.content.append(ContentData( name: "Pizzas", idx: 2) )
                self.content.append(ContentData( name: "Chinese", idx: 3) )
                self.content.append(ContentData( name: "ABCD", idx: 4) )
                self.content.append(ContentData( name: "EFGH", idx: 5) )
                self.content.append(ContentData( name: "IJKL", idx: 6) )
                self.offsets.append(0)
                self.offsets.append(0)
                self.offsets.append(0)
                self.offsets.append(0)
                self.offsets.append(0)
                self.offsets.append(0)
                self.offsets.append(0)
                self.offsets.append(0)

                //print(dishModel)
            }
                
                //print(self.dishModel2d)
            
            
            
             
        }
         
    }
         
    
    private func getContentView() -> some View{
        ZStack{
            //LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            VStack{
                List{
                    ForEach(0..<content.count, id: \.self){ idx in
                        VStack{
                            if(idx == 0){
                                heading()
                                    
                                    //.background(Color.black.opacity(0.2))
                                    .shadow(radius: 6)
                                    .cornerRadius(10)
                                    
                                
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
                                /*
                                .background(GeometryReader{ proxy -> Color in
                                    
                                    DispatchQueue.main.async {
                                        /*
                                        content[idx] = ContentData(id: content[idx].id, name: content[idx].name, isOpen: content[idx].isOpen, idx: content[idx].idx, offset: proxy.frame(in: .named("scroll")).origin.y)
                                         */
                                        self.offsets[idx] = proxy.frame(in: .named("scroll")).origin.y
                                        print(idx, self.offsets)
                                        var flag = 0
                                        for i in 0..<self.offsets.count{
                                            print(i)
                                            if(self.offsets[i] > 100.0 && self.offsets[i] < 150){
                                                self.descArray = []
                                                self.descArray.append(content[i - 1].name)
                                                flag = 1
                                                break
                                            }
                                        }
                                        if(flag == 0){
                                            self.descArray = []
                                            self.descArray.append(content[content.count - 1].name)
                                        }
                                        print(descArray)
                                        /*
                                        if(offset < 110
                                           && offset > 0
                                           && idx >= 1){
                                            if((idx - 1) == descArray.count){
                                                descArray.append(content[idx].name)
                                            }
                                            
                                        }
                                        else if(offset > 110 && idx >= 1){
                                            if(descArray.count <= 0){
                                                
                                            }
                                            else if(descArray[descArray.count - 1] == content[idx].name){
                                                descArray.remove(at: descArray.count - 1)
                                            }
                                         
                                        }
                                         */
                                        
                                    }
                                    return Color.white
                                })
                                
                                */
                                //Group{
                                
                                if(content[idx].isOpen){
                                    //var count = dishModel2d[content[idx].idx].count
                                    ForEach(Array(dishModel2d[content[idx].idx].enumerated()), id: \.offset){ (index, curDish) in
                                        
                                        row(cd: curDish)
                                        
                                        if(index < 2){
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
                        
                        .padding(idx == 0 ? 0 : 10)
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
                
//                LinearGradient(colors: [Color("White"), Color("LightGrey")], startPoint: .top, endPoint: .bottom)
//
//                .frame(maxWidth: .infinity)
//                .frame(height: 20)
                 
            }
        }
    }
    private func row(cd curDish:DishModel) -> some View{
        return HStack{
            VStack(alignment: .leading, spacing: 10){
                Image(systemName: "dot.square").foregroundColor(curDish.isVeg! ? Color("Green") : Color.red).bold()
                Text(curDish.name!).font(Font(CTFont(.system, size: 16))).bold()
                HStack{
                    Text(curDish.rating!)
                        .lineLimit(1)
                        .padding(4)
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
                        .onAppear(){
                        }
                    if(imageForDish[curDish] == nil){
                        Image(systemName: "circle.dashed").frame(width: 140 ,height: 140)
                            .scaledToFill().cornerRadius(10)
                    }
                    else{
                        imageForDish[curDish]!.resizable().transition(.scale(scale: 0.1, anchor: .center))
                            //.transaction(Transaction(animation: .easeInOut))
                            .frame(width: 140 ,height: 140)
                            .scaledToFill().cornerRadius(10)
                    }
                    
                    HStack{
                        Spacer()
                    }.frame(height: 10)
                     
                }.frame(maxHeight: .infinity)
                
                if(getQuantity(curDish: curDish) == -1){
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
                    .onTapGesture {
                        if(cartItems.count != 0){
                            if(cartItems[0].restaurantName != restaurantModel.name!){
                                showRemoveCurDish = curDish
                                showRemove = true
                                
                                return
                            }
                        }
                        var dishFound = -1
                        for i in 0..<cartItems.count{
                            if(cartItems[i].name == curDish.name!){
                                dishFound = i
                                break
                            }
                        }
                        if(dishFound != -1){
                            cartItems[dishFound] = Food(id: cartItems[dishFound].id, name: cartItems[dishFound].name, price: cartItems[dishFound].price, quantity: cartItems[dishFound].quantity + 1, isVeg: cartItems[dishFound].isVeg, restaurantName: cartItems[dishFound].restaurantName, distance: cartItems[dishFound].distance)
                        }
                        else{
                            cartItems.append(Food(name: curDish.name!, price: curDish.price!, quantity: 1, isVeg: curDish.isVeg!, restaurantName: restaurantModel.name!, distance: restaurantModel.distance!))
                        }
                        DispatchQueue.main.async {
                            DatabaseHelper.shared.updateCart(cartItems: cartItems, userData: userData)
                        }
                    }
                    .alert("U have items from other restaurant in cart, Press Yes to clear cart and continue", isPresented: $showRemove, actions: {
                        Button("No", role: .cancel, action: {
                            
                            showRemove = false
                        })
                        Button("Yes", role: .destructive, action: {
                            cartItems = []
                            cartItems.append(Food(name: showRemoveCurDish!.name!, price: showRemoveCurDish!.price!, quantity: 1, isVeg: showRemoveCurDish!.isVeg!, restaurantName: restaurantModel.name!, distance: restaurantModel.distance!))
                                DatabaseHelper.shared.updateCart(cartItems: cartItems, userData: userData)
                            print(cartItems)
                            showRemove = false
                        })
                    })
                }
                else{
                    PlusMinusBig(cartItems: $cartItems, food: $cartItems[getQuantity(curDish: curDish)], id:cartItems[getQuantity(curDish: curDish)].id, subTotal: $dummySubtotal, userData: $userData)
                        .font(Font(CTFont(.system, size: 16))).bold()

                        .padding(.trailing, 20)
                }
                
                
            }.frame(maxHeight: .infinity)
        }
        //.animation(Animation.easeInOut(duration: 0.2))
        
    }
    func getQuantity(curDish:DishModel) -> Int{
        var quantity = -1
        if(cartItems.count == 0 || cartItems[0].restaurantName != restaurantModel.name!){
            return quantity
        }
        for i in 0..<cartItems.count{
            if(cartItems[i].name == curDish.name!){
                return i
            }
        }
        
        return quantity
        
    }
    func heading() -> some View{
        return HStack{
            VStack(alignment: .leading, spacing: 6){
                Text(restaurantModel.name!).font(Font(CTFont(.system, size: 20))).bold()
                Text(filterCategory[Int(restaurantModel.category!)! - 1].category)
                Text(restaurantModel.location!).foregroundColor(Color("Grey"))
                HStack{
                    Image(systemName: "deskclock.fill")
                    Text("\(Int(restaurantModel.distance! * 5)) mins | \(String(format: "%.2f",restaurantModel.distance!)) km away")
                }
                
            }
            Spacer()
            VStack(spacing: 0){
                VStack{
                    Text("\(restaurantModel.rating!.count) ★").font(Font(CTFont(.system, size: 20))).bold()
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                }.background(Color("Green"))
                    .foregroundColor(Color.white)
                    .upperCurve(10, corners: [.topLeft, .topRight])
                VStack{
                    Text("\(restaurantModel.price!)K").bold()
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

struct PlusMinusBig:View{
    @Binding var cartItems:[Food]
    
    @State var showRemove = false
    @Binding var food:Food
    @State var id: UUID?
    @State var index = 0
    @Binding var subTotal:Int
    @Binding var userData:UserData?
    var body: some View{
        HStack(spacing: 4){
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
                cartItems[index] = Food(id: cartItems[index].id, name: cartItems[index].name, price: cartItems[index].price, quantity: cartItems[index].quantity - 1, isVeg: cartItems[index].isVeg, restaurantName: cartItems[index].restaurantName, distance: cartItems[index].distance)
                DatabaseHelper.shared.updateCart(cartItems: cartItems, userData: userData)
                subTotal = subTotal - cartItems[index].price
            }
            .alert("Do you want to remove this Item from Cart", isPresented: $showRemove, actions: {
                Button("No", role: .cancel, action: {
                    
                    showRemove = false
                })
                Button("Yes", role: .destructive, action: {
                    subTotal = subTotal - cartItems[index].price
                    cartItems.remove(at: index)
                    DatabaseHelper.shared.updateCart(cartItems: cartItems, userData: userData)
                    showRemove = false
                })
            })
            Spacer()
            Text("\(food.quantity)").font(Font(CTFont(.system, size: 14))).frame(width: 20)
            Spacer()
            Text("+").padding(.trailing, 8).onTapGesture {
                for i in cartItems.indices{
                    if(id == cartItems[i].id){
                        index = i
                        break
                    }
                }
                cartItems[index] = Food(id: cartItems[index].id, name: cartItems[index].name, price: cartItems[index].price, quantity: cartItems[index].quantity + 1, isVeg: cartItems[index].isVeg, restaurantName: cartItems[index].restaurantName, distance: cartItems[index].distance
                )
                DatabaseHelper.shared.updateCart(cartItems: cartItems, userData: userData)

                subTotal = subTotal + cartItems[index].price
                
            }
        }
        .frame(width: 100, height: 32)
        .background(Color("Light"))
        .foregroundColor(Color("Dark"))
        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("Dark"), lineWidth: 2))
        .cornerRadius(6)
        
        .onAppear(){
            
        }
    }
}
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
extension View {
// This function changes our View to UIView, then calls another function
// to convert the newly-made UIView to a UIImage.
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
// here is the call to the function that converts UIView to UIImage: `.asUIImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
