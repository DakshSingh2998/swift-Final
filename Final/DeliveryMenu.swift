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
    @State var vegOnly = false
    @ObservedObject var filterMin = TextModel()
    @ObservedObject var filterMax = TextModel()
    @State var tempIsIncorrect = false
    @State var tfWidth = CommonMethods.shared.width / 2 - 20
    @State var filterCategory:[FilterCategory] = []
    @State var filterCategoryCount = 0
    var body: some View {
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
                        .frame(height: 64)
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                    VStack{
                        HStack{
                            Image(systemName: "magnifyingglass").resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color("Dark"))
                            TextField("Restaurant name or a Dish", text: $searchText).bold(false)
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
                        ForEach(cartItems) { item in
                            VStack(spacing: 0){
                                //Text(item.name)
                                FoodItemCell(height: 200.0).frame(height: 200)
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
                                            .background(Circle().fill(item.idx == sortSelected ? Color("Dark") : Color.white))
                                        
                                    }
                                    .frame(width: 14, height: 14)
                                    .background(Circle().fill(Color.white))
                                }.frame(width: 18, height: 18)
                                    .background(Circle().fill(item.idx == sortSelected ? Color("Dark") : Color("Grey")))
                                
                                
                            }.frame(height: 18)
                                .contentShape(Rectangle())
                                .onTapGesture(perform: {
                                    
                                    sortSelected = item.idx
                                    
                                    
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
                            Toggle("veg only", isOn: $vegOnly)
                        }
                        HStack{
                            Spacer()
                        }
                        .frame(height: 1)
                        .background(Color("Grey"))
                        Text("Price")
                        HStack{
                            CustomTextField(defaultplaceholder: "Min", vm: filterMin, width: $tfWidth, isInCorrect: $tempIsIncorrect, commitClosure: {
                                
                            })
                            Spacer()
                            CustomTextField(defaultplaceholder: "Max", vm: filterMax, width: $tfWidth, isInCorrect: $tempIsIncorrect, commitClosure: {
                                
                            })
                        }.padding(.vertical, -10)
                        HStack{
                            Spacer()
                        }
                        .frame(height: 1)
                        .background(Color("Grey"))
                        Text("Category")
                        VStack(spacing: 10){
                            ForEach(1...(((filterCategory.count / 3) + (filterCategory.count % 3 == 0 ? 0 : 1 ))), id: \.self) {idx in
                                HStack{
                                    Text("\(filterCategory[((idx - 1) * 3)].category)")
                                        .padding(.horizontal, 8)
                                        .padding(.all, 4)
                                        .background(filterCategory[((idx - 1) * 3)].isSelected ? Color("Dark") :  Color("Light"))
                                        .cornerRadius(6)
                                        .onTapGesture(perform: {
                                            filterCategory[((idx - 1) * 3)] = FilterCategory(category: filterCategory[((idx - 1) * 3)].category, idx: filterCategory[((idx - 1) * 3)].idx, isSelected: !filterCategory[((idx - 1) * 3)].isSelected)
                                        })
                                    Spacer()
                                    if(((idx - 1) * 3 + 1) < filterCategory.count){
                                        Text("\(filterCategory[((idx - 1) * 3 + 1)].category)")
                                            .padding(.horizontal, 8)
                                            .padding(.all, 4)
                                            .background(filterCategory[((idx - 1) * 3 + 1)].isSelected ? Color("Dark") :  Color("Light"))
                                            .cornerRadius(6)
                                            .onTapGesture(perform: {
                                                filterCategory[((idx - 1) * 3 + 1)] = FilterCategory(category: filterCategory[((idx - 1) * 3 + 1)].category, idx: filterCategory[((idx - 1) * 3 + 1)].idx, isSelected: !filterCategory[((idx - 1) * 3 + 1)].isSelected)
                                            })
                                    }
                                    Spacer()
                                    if(((idx - 1) * 3 + 2) < filterCategory.count){
                                        Text("\(filterCategory[((idx - 1) * 3 + 2)].category)")
                                            .padding(.horizontal, 8)
                                            .padding(.all, 4)
                                            .background(filterCategory[((idx - 1) * 3 + 2)].isSelected ? Color("Dark") :  Color("Light"))
                                            .cornerRadius(6)
                                            .onTapGesture(perform: {
                                                filterCategory[((idx - 1) * 3 + 2)] = FilterCategory(category: filterCategory[((idx - 1) * 3 + 2)].category, idx: filterCategory[((idx - 1) * 3 + 2)].idx, isSelected: !filterCategory[((idx - 1) * 3 + 2)].isSelected)
                                            })
                                    }
                                    
                                    
                                    
                                }
                                
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
                                
                            })
                            .padding(.horizontal, 32)
                        CustomPrimaryButton(title: "Apply", height: 32, colorr: Color("Dark"), textColor: Color.white, closure: {
                            
                        })
                    }
                    .padding(.bottom, 10)
                }
                .padding(.horizontal, 10)
                .background(Color.white)
                    .upperCurve(10, corners: [.topLeft, .topRight])

                
                
            }.background(.clear)
                
                .padding(.bottom, sortPaddingBottom)
                .isHidden(sortHidden)
                
        }
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
            cartItems.append(Food(name: "Margherita", price: 100, quantity: 1))
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
            filterCategory.append(FilterCategory(category: "Chinese", idx: 6))
            filterCategory.append(FilterCategory(category: "Chinese", idx: 7))
            filterCategory.append(FilterCategory(category: "Chinese", idx: 7))
            filterCategory.append(FilterCategory(category: "Chinese", idx: 7))

            print(filterCategory.count)
            
        }
        .onDisappear(){
            sortHidden = true
        }
        
    }
    func sortHide(){
        
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
