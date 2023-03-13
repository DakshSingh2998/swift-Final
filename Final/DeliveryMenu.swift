//
//  DeliveryMenu.swift
//  Final
//
//  Created by Daksh on 21/02/23.
//

import SwiftUI
struct sortCategory: Identifiable{
    @State var id = UUID()
    @State var category:String
    @State var idx = 0
}
struct FilterCategory: Identifiable{
    @State var id = UUID()
    @State var category:String
    @State var idx = 0
    @State var isSelected = false
}


struct DeliveryMenu: View {
    @Binding var cartItems:[Food]
    @State var sortCategoryList:[sortCategory] = []
    @Binding var onPage:Int
    @Binding var ONPAGE:Double
    @State var searchText = ""
    @State var sortHidden = true
    @State var filterHidden = true
    @State var sortPaddingBottom = -9999.0
    @State var sortSelected = -1
    @State var tempSortSelected = -1
    @State var vegOnly = false
    @State var tempVegOnly = false
    @ObservedObject var filterMin = TextModel()
    @ObservedObject var tempFilterMin = TextModel()
    @ObservedObject var filterMax = TextModel()
    @ObservedObject var tempFilterMax = TextModel()
    @State var tempIsIncorrect = false
    @State var tfWidth = CommonMethods.shared.width / 2 - 20
    @State var filterCategory:[FilterCategory] = []
    @State var tempFilterCategory:[FilterCategory] = []
    @State var filterCategoryCount = 0
    @State var gotoRestaurantHomePage = false
    @Binding var restaurantModel:[RestaurantModel]
    @State var originalRestauratnModel:[RestaurantModel] = []
    @State var restaurantDishUrl = ""
    @State var showRestaurantModel:[RestaurantModel] = []
    @State var onTapped = RestaurantModel(isVeg: false, distance: 0, price: 0, isLiked: false, id: 0, category: "", rating: "", name: "", location: "")
    @State var didLoad = true

    var body: some View {
        ScrollViewReader{scrollProxy in
            ZStack(alignment: .bottom){
                
                ZStack(alignment: .top){
                    //LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                    
                    /*
                     VStack{
                     
                     }
                     .frame(maxWidth: .infinity)
                     .frame(height: 64)
                     .overlay()
                     */
                    VStack(spacing: 0){
                        CustomNavigation(title: "Delivery" , ONPAGE: $ONPAGE, leftImage: "location.north.circle.fill")
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        VStack{
                            HStack{
                                Image(systemName: "magnifyingglass").resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("Dark"))
                                TextField("Restaurant name or a Dish", text: $searchText).disableAutocorrection(true)
                                    .bold(false)
                                    .onSubmit({
                                    applyFilter()
                                    applySort(scrollProxy: scrollProxy)
                                })
                                Spacer()
                                HStack{
                                    Spacer()
                                }.frame(width: 1, height: 20)
                                    .background(Color("Grey"))
                                Image(systemName: "mic").resizable()
                                    .frame(width: 14, height: 20)
                                    .foregroundColor(Color("Dark"))
                                    .padding(.leading, 8)
                                
                            }
                            .bold()
                            .padding(8)
                            .background(Color.white)
                            //.overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("DarkGrey"), lineWidth:2))
                            
                            .cornerRadius(6)
                            .padding(6)
                        }
                        .shadow(radius: 6)
                        HStack{
                            
                            Button(action:{
                                sortShow()
                                
                            }){
                                Image(systemName: "slider.horizontal.3").resizable()
                                    .frame(width: 12, height: 10)
                                Text("Sort ▼")
                            }.font(Font(CTFont(.system, size: 12)))
                                .foregroundColor(Color.black)
                                .padding(4)
                                .overlay(RoundedCorner(radius: 6).stroke(Color("Grey"), lineWidth:0.5))
                                .background(Rectangle().fill(Color.white).shadow(radius: 6))
                                .cornerRadius(6)
                            //
                            Button(action:{
                                sortShow()
                                filterHidden = false
                            }){
                                Image(systemName: "highlighter").resizable()
                                    .frame(width: 12, height: 10)
                                Text("Filter ▼")
                            }.font(Font(CTFont(.system, size: 12)))
                                .foregroundColor(Color.black)
                                .padding(4)
                                .overlay(RoundedCorner(radius: 6).stroke(Color("Grey"), lineWidth:0.5))
                                .background(Rectangle().fill(Color.white).shadow(radius: 6))
                                .cornerRadius(6)
                            
                            
                            
                            
                            Spacer()
                        }.padding(6)
                        
                        
                        List{
                            ForEach(0..<restaurantModel.count, id: \.self) { idx in
                                VStack(spacing: 0){
                                    //Text(item.name)
                                    
                                    FoodItemCell(restaurantModel: $restaurantModel, showRestaurantModel: $restaurantModel[idx], idx: idx, height: 200.0, filterCategory: filterCategory).frame(height: 200)
                                        .id(idx)
                                        .onTapGesture(perform: {
                                            restaurantDishUrl = "https://retoolapi.dev/kzWdFZ/jaimatadi"
                                            onTapped = restaurantModel[idx]
                                            gotoRestaurantHomePage = true
                                        })
                                    
                                                                    }
                                .padding(12)
                                //.background(Color.black.opacity(0.2))
                                .shadow(radius: 6)
                                .cornerRadius(10)
                            }
                            .padding(.vertical, -12)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listSectionSeparator(.hidden)
                        }
                        .background(.clear)
                        .padding(.horizontal, -30)
                    }
                    
                    VStack{
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(1 - (sortPaddingBottom * -1) / 400 - 0.2))
                    .isHidden(sortHidden)
                    
                    
                }
                .frame(maxHeight: .infinity)
                
                .onTapGesture(perform: {
                    sortHide()
                    
                })
                VStack{
                    Button(action: {
                        sortHide()
                    }){
                        Spacer()
                        Text("X")
                        Spacer()
                    }
                    .padding(10)
                    .foregroundColor(Color.white)
                    .background(Circle().fill(Color.black.opacity(0.7)))
                    VStack(alignment: .leading, spacing: 10){
                        Text(filterHidden ? "Sort" : "Filter").bold()
                        
                            .padding(.top, 20)
                        HStack{
                            Spacer()
                        }
                        .frame(height: 1)
                        .background(Color("Grey"))
                        if(filterHidden){
                            List(sortCategoryList, id: \.id){ item in
                                HStack{
                                    Text(item.category)
                                    Spacer()
                                    VStack{
                                        VStack{
                                            VStack{
                                                Spacer()
                                            }.frame(width: 8, height: 8)
                                                .background(Circle().fill(item.idx == tempSortSelected ? Color("Dark") : Color.white))
                                            
                                        }
                                        .frame(width: 14, height: 14)
                                        .background(Circle().fill(Color.white))
                                    }.frame(width: 18, height: 18)
                                        .background(Circle().fill(item.idx == tempSortSelected ? Color("Dark") : Color("Grey")))
                                    
                                    
                                }.frame(height: 18)
                                    .contentShape(Rectangle())
                                    .onTapGesture(perform: {
                                        
                                        tempSortSelected = item.idx
                                        
                                        
                                    })
                                
                                
                                    .padding(.horizontal, -10)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                    .listSectionSeparator(.hidden)
                            }
                            .listStyle(.plain)
                            .scrollDisabled(true)
                            .frame(height: 44 * CGFloat(sortCategoryList.count))
                            .padding(0)
                            ////
                        }
                        else{
                            HStack{
                                Text("Veg Only")
                                Spacer()
                                Toggle("veg only", isOn: $tempVegOnly)
                            }
                            HStack{
                                Spacer()
                            }
                            .frame(height: 1)
                            .background(Color("Grey"))
                            Text("Price")
                            HStack{
                                CustomTextField(defaultplaceholder: "Min", vm: tempFilterMin, width: $tfWidth, isInCorrect: $tempIsIncorrect, isNumeric: true, commitClosure: {
                                    
                                })
                                Spacer()
                                CustomTextField(defaultplaceholder: "Max", vm: tempFilterMax, width: $tfWidth, isInCorrect: $tempIsIncorrect, isNumeric: true, commitClosure: {
                                    
                                })
                            }.padding(.vertical, -10)
                            HStack{
                                Spacer()
                            }
                            .frame(height: 1)
                            .background(Color("Grey"))
                            Text("Category")
                            VStack(spacing: 10){
                                ForEach(1...(((tempFilterCategory.count / 3) + (tempFilterCategory.count % 3 == 0 ? 0 : 1 ))), id: \.self) {idx in
                                    HStack{
                                        Text("\(tempFilterCategory[((idx - 1) * 3)].category)")
                                            .padding(.horizontal, 8)
                                            .padding(.all, 4)
                                            .background(tempFilterCategory[((idx - 1) * 3)].isSelected ? Color("Dark") :  Color("Light"))
                                            .cornerRadius(6)
                                            .onTapGesture(perform: {
                                                tempFilterCategory[((idx - 1) * 3)] = FilterCategory(category: tempFilterCategory[((idx - 1) * 3)].category, idx: tempFilterCategory[((idx - 1) * 3)].idx, isSelected: !tempFilterCategory[((idx - 1) * 3)].isSelected)
                                            })
                                        //Spacer()
                                        if(((idx - 1) * 3 + 1) < tempFilterCategory.count){
                                            Text("\(tempFilterCategory[((idx - 1) * 3 + 1)].category)")
                                                .padding(.horizontal, 8)
                                                .padding(.all, 4)
                                                .background(tempFilterCategory[((idx - 1) * 3 + 1)].isSelected ? Color("Dark") :  Color("Light"))
                                                .cornerRadius(6)
                                                .onTapGesture(perform: {
                                                    tempFilterCategory[((idx - 1) * 3 + 1)] = FilterCategory(category: tempFilterCategory[((idx - 1) * 3 + 1)].category, idx: tempFilterCategory[((idx - 1) * 3 + 1)].idx, isSelected: !tempFilterCategory[((idx - 1) * 3 + 1)].isSelected)
                                                })
                                        }
                                        //Spacer()
                                        if(((idx - 1) * 3 + 2) < tempFilterCategory.count){
                                            Text("\(tempFilterCategory[((idx - 1) * 3 + 2)].category)")
                                                .padding(.horizontal, 8)
                                                .padding(.all, 4)
                                                .background(tempFilterCategory[((idx - 1) * 3 + 2)].isSelected ? Color("Dark") :  Color("Light"))
                                                .cornerRadius(6)
                                                .onTapGesture(perform: {
                                                    tempFilterCategory[((idx - 1) * 3 + 2)] = FilterCategory(category: tempFilterCategory[((idx - 1) * 3 + 2)].category, idx: tempFilterCategory[((idx - 1) * 3 + 2)].idx, isSelected: !tempFilterCategory[((idx - 1) * 3 + 2)].isSelected)
                                                })
                                        }
                                        
                                        
                                        
                                    }.frame(maxWidth: .infinity)
                                    
                                }
                            }
                        }
                        HStack{
                            Spacer()
                        }
                        .frame(height: 1)
                        .background(Color("Grey"))
                        HStack{
                            Text("Clear All")
                                .foregroundColor(Color("Dark"))
                                .onTapGesture(perform: {
                                    if(filterHidden == true){
                                        tempSortSelected = -1
                                    }
                                    else{
                                        tempVegOnly = false
                                        tempFilterMin.value = ""
                                        tempFilterMax.value = ""
                                        for i in 0..<tempFilterCategory.count{
                                            tempFilterCategory[i] = FilterCategory(category: tempFilterCategory[i].category, idx: tempFilterCategory[i].idx, isSelected: false)
                                        }
                                        
                                    }
                                    
                                    
                                })
                                .padding(.horizontal, 32)
                            CustomPrimaryButton(title: "Apply", height: 32, colorr: Color("Dark"), textColor: Color.white, closure: {
                                if(filterHidden == true){
                                    sortSelected = tempSortSelected
                                    
                                }
                                else{
                                    vegOnly = tempVegOnly
                                    filterMin.value = tempFilterMin.value
                                    filterMax.value = tempFilterMax.value
                                    filterCategory = tempFilterCategory
                                }
                                applyFilter()
                                applySort(scrollProxy: scrollProxy)
                                
                                sortHide()
                            })
                        }
                        .padding(.bottom, 10)
                    }
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .upperCurve(10, corners: [.topLeft, .topRight])
                    
                    
                    
                }.background(.clear)
                    .font(Font(CTFont(.system, size: 16)))
                    .padding(.bottom, sortPaddingBottom)
                    .isHidden(sortHidden)
                
                NavigationLink(destination: RestaurantHomePage(restuarantDishUrl: $restaurantDishUrl, restaurantModel: onTapped, filterCategory: filterCategory, cartItems: $cartItems), isActive: $gotoRestaurantHomePage){
                }.hidden()
                
                    .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local)
                        .onEnded({ value in
                            if(sortHidden == true){
                                return
                            }
                            if value.translation.width < 0 {
                                // left
                                sortShow()
                            }
                            
                            if value.translation.width > 0 {
                                // right
                                sortShow()
                            }
                            if value.translation.height < 0 {
                                // up
                                sortShow()
                            }
                            
                            if value.translation.height > 0 {
                                // down
                                if(value.translation.height > 140){
                                    sortHide()
                                }
                                else{
                                    sortShow()
                                }
                            }
                        })
                            .onChanged{change in
                                if(sortHidden == true){
                                    return
                                }
                                var start_height = change.startLocation.y
                                var cur_height = change.location.y
                                var diff = cur_height - start_height
                                if(diff > 11){
                                    //print(diff)
                                    sortPaddingBottom = diff * -1
                                    return
                                }
                            }
                             
                    )
                //.frame(maxWidth: .infinity)
                    .onAppear(){
                        if(didLoad){

                            
                            loadApi()
                            //cartItems.append(Food(name: "Margherita", price: 100, quantity: 1))
                            sortCategoryList = []
                            sortCategoryList.append(sortCategory(category: "Rating: High To Low", idx: 0))
                            
                            sortCategoryList.append(sortCategory(category: "Delivery Time : Low to High", idx: 1))
                            sortCategoryList.append(sortCategory(category: "Distance: Low to High", idx: 2))
                            sortCategoryList.append(sortCategory(category: "Cost: Low to High", idx: 3))
                            sortCategoryList.append(sortCategory(category: "Cost: High To Low", idx: 4))
                            filterCategory = []
                            
                            filterCategory.append(FilterCategory(category: "North Indian", idx: 0))
                            filterCategory.append(FilterCategory(category: "South Indian", idx: 1))
                            filterCategory.append(FilterCategory(category: "East Indian", idx: 2))
                            filterCategory.append(FilterCategory(category: "West Indian", idx: 3))
                            filterCategory.append(FilterCategory(category: "Eastern", idx: 4))
                            filterCategory.append(FilterCategory(category: "Western", idx: 5))
                            tempFilterCategory = filterCategory
                            print(filterCategory.count)
                            //didLoad = false
                        }
                    }
                    .onDisappear(){
                        sortHidden = true
                    }
            }
        }
    }
    
    func loadApi(){
        NetworkManager.shared.getApi(url: "https://retoolapi.dev/UY30s0/hum_name_rahe_hum_jo_the_kabhi"){
            data in
            guard let data = data as? [[String: Any]] else {return}
            let values = data
            //print(values)
            self.restaurantModel = values.map{RestaurantModel(data: $0)}
            self.originalRestauratnModel = self.restaurantModel
            //self.showRestaurantModel = restaurantModel
        }
    }
    func applySort(scrollProxy: ScrollViewProxy){
        
        if(sortSelected == 0){
            //print(restaurantModel[0].rating!.count)
            restaurantModel = restaurantModel.sorted{
                $0.rating! > $1.rating!
            }
        }
        else if(sortSelected == 1 || sortSelected == 2){
            restaurantModel = restaurantModel.sorted{
                $0.category! < $1.category!
            }
        }
        else if(sortSelected == 3){
            restaurantModel = restaurantModel.sorted{
                $0.price! < $1.price!
            }
        }
        else if(sortSelected == 4){
            restaurantModel = restaurantModel.sorted{
                $0.price! > $1.price!
            }
        }
        else if(sortSelected == -1){
            restaurantModel = restaurantModel
        }
        print(restaurantModel.count)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            withAnimation(.linear(duration: 0.3)){
                scrollProxy.scrollTo(0)
            }
        })
        
        
        //showRestaurantModel = restaurantModel
    }
    func applyFilter(){
        self.showRestaurantModel = originalRestauratnModel.filter{
            ($0.price!) >= Int(filterMin.value == "" ? "0" : filterMin.value)! && $0.price! <= Int(filterMax.value == "" ? "99999" : filterMax.value)!
        }
        if(vegOnly == true){
            self.showRestaurantModel = self.showRestaurantModel.filter{
                $0.isVeg == true
            }
        }
        if(searchText != ""){
            self.showRestaurantModel = self.showRestaurantModel.filter{
                $0.name!.lowercased().contains(searchText.lowercased()) || $0.location!.lowercased().contains(searchText.lowercased())
            }
        }
        var flagFilterCategory = false
        for i in filterCategory{
            if(i.isSelected == true){
                flagFilterCategory = true
            }
        }
        if(flagFilterCategory){
            self.showRestaurantModel = self.showRestaurantModel.filter{
                return filterCategory[Int($0.category!)! - 1].isSelected
            }
        }
        
        
        self.restaurantModel = showRestaurantModel
    }
    func sortHide(){
        tempSortSelected = sortSelected
        tempVegOnly = vegOnly
        tempFilterMin.value = filterMin.value
        tempFilterMax.value = filterMax.value
        tempFilterCategory = filterCategory
        
        withAnimation(.linear(duration: 0.2)){
            sortPaddingBottom = -9999.0
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
            sortHidden = true
            filterHidden = true
        })
        
    }
    func sortShow(){
        sortHidden = false
        
        withAnimation(.linear(duration: 0.2)){
            sortPaddingBottom = 0
            
        }
    }
}
/*
 struct DeliveryMenu_Previews: PreviewProvider {
 static var previews: some View {
 DeliveryMenu()
 }
 }
 */
