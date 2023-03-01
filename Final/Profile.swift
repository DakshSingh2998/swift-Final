//
//  Profile.swift
//  Final
//
//  Created by Daksh on 27/02/23.
//

import SwiftUI

struct Section: Identifiable{
    @State var id = UUID()
    @State var sectionName = ""
    @State var sectionNumber:Int = 0
}
struct childSection: Identifiable{
    @State var id = UUID()
    @State var name = ""
    
    @State var image = ""
    @State var idx = -1
}

struct Profile: View {
    @Environment(\.dismiss) var dismiss
    @State var sectionList:[Section] = []
    @State var sectionChildList:[[childSection]] = []
    @State var secNo = 0
    @State var i = 0
    @State var toast:String?
    @Binding var ONPAGE:Double
    var body: some View {
        ZStack(alignment: .top){
            LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack{
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .overlay(CustomNavigation(title: "Profile" , ONPAGE: $ONPAGE, rightImage: ""))
            VStack(spacing: 0){
                VStack{
                    HStack{
                        VStack{
                            Text("Name").font(Font(CTFont(.system, size: 24))).bold()
                            Text("email").font(Font(CTFont(.system, size: 18)))
                        }
                        Spacer()
                        VStack{
                            Image("BlinkitLogo").resizable().scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(50)
                        }
                    }
                    .padding(20)
                }
                .frame(maxWidth: .infinity)
                .background(Color("Light"))
                .upperCurve(10, corners: [.topLeft, .topRight])
                //.cornerRadius(10)
                
                LinearGradient(gradient: Gradient(colors: [Color("Light"), Color("Dark")]), startPoint: .top, endPoint: .bottom)
                    .frame(height: 8)
                    .upperCurve(10, corners: [.bottomLeft, .bottomRight])
                
                    .background(.clear)
                
                List{
                    //VStack(alignment: .leading){
                    /*
                        VStack{

                        }.frame(maxWidth: .infinity)
                        .background(.clear)
                            .frame(height: 20)
                     */
//                        VStack(alignment: .leading, spacing: 10){
//                            VStack(alignment: .leading, spacing: 16){
                                ForEach(sectionList) { list in
                                    VStack(alignment: .leading, spacing: 6){


                                        Text(list.sectionName).font(Font(CTFont(.system, size: 18)))
                                            .bold()
                                        ForEach(sectionChildList[list.sectionNumber]){ child in
                                            VStack(spacing: 6){
                                                HStack{
                                                    Image(systemName: child.image).frame(width: 20, height: 20)
                                                    Text(child.name).font(Font(CTFont(.system, size: 16)))
                                                    Spacer()
                                                    Text(">")
                                                }
                                                .contentShape(Rectangle())
                                                .padding(.horizontal, 6)
                                                .onTapGesture(perform: {
                                                    if(child.name == "Log Out"){
                                                        //log out
                                                        toast = "Log Out Successful"
                                                        //addDummyData()
                                                    }
                                                    if(child.name == "About"){
                                                        toast = "No About, Come back later"
                                                    }
                                                })
                                                if(child.idx < sectionChildList[list.sectionNumber].count - 1){
                                                    HStack{
                                                        VStack{

                                                        }
                                                        .frame(width: 40, height: 4)
                                                        VStack{

                                                        }

                                                        .frame(maxWidth: .infinity)
                                                        .padding(.leading, 20)
                                                        .frame(height: 2)

                                                        .background(Color("Dark"))
                                                        .cornerRadius(10)
                                                    }
                                                    .padding(.horizontal, -10)

                                                }
                                            }
                                        }

                                    }
                                }.padding(10)
                                    .background(Color("Light"))
                                    .cornerRadius(10)
                                    //.cornerRadius(10)
//                            }
//                            .frame(maxWidth: .infinity)
//                            .padding(.vertical, 16)
//                            .padding(.horizontal, 20)

                        //}
//                        .padding(.horizontal, -10)
//                        .frame(maxWidth: .infinity)
//                        .background(.clear)
//
//                        .cornerRadius(10)
                    //}
                    .padding(.horizontal, -20)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                }
                .listStyle(.plain)
                //.padding(.horizontal, -10)
                .padding(.top, -2)
                .frame(minHeight: 10)
                //.cornerRadius(10)
                .background(.clear)
            Spacer()
                
        }
            .padding(.top, 64)
            .padding(.all, 10)
            
            
            if(toast != nil){
                VStack{
                    Text(toast ?? "").bold()
                        .padding(6)
                }
                //.padding(.top, 30)
                .background(Color("Dark"))
                
                .cornerRadius(10)
                .padding(.top, 50)
                //.ignoresSafeArea()
                    .onAppear(){
                        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                            toast = nil
                        })
                    }
            }
            
        }.animation(.linear(duration: 0.2))
            .navigationBarHidden(true)
        .onAppear(){
            
            sectionList.append(Section(sectionName: "Food Order", sectionNumber: 0))
            sectionList.append(Section(sectionName: "More", sectionNumber: 1))
            //sectionList.append(Section(sectionName: "Dummy", sectionNumber: 2))
            
            sectionChildList.append([childSection(name: "Your orders", image: "takeoutbag.and.cup.and.straw.fill", idx: 0), childSection(name: "Address Book", image: "text.book.closed.fill", idx: 1)])
            sectionChildList.append([childSection(name: "About", image: "info.circle", idx: 0), childSection(name: "Log Out", image: "power.circle.fill", idx: 1)])
            
            
            
            /*
            sectionChildList.append([childSection(name: "DD", image: "power.circle.fill"), childSection(name: "Log Out", image: "power.circle.fill"), childSection(name: "Log Out", image: "power.circle.fill"), childSection(name: "Log Out", image: "power.circle.fill"), childSection(name: "Log Out", image: "power.circle.fill"), childSection(name: "Log Out", image: "power.circle.fill"), childSection(name: "Log Out", image: "power.circle.fill"), childSection(name: "Log Out", image: "power.circle.fill"), childSection(name: "Log Out", image: "power.circle.fill"), childSection(name: "Log Out", image: "power.circle.fill"), childSection(name: "Log Out", image: "power.circle.fill"), childSection(name: "Log Out", image: "power.circle.fill"), childSection(name: "Log Out", image: "power.circle.fill"), childSection(name: "Log Out", image: "power.circle.fill"), childSection(name: "Log Out", image: "power.circle.fill")])
             */
            //print(sectionChildList)
        }
        .onChange(of: ONPAGE){newVal in
            if(ONPAGE < 5.0){
                dismiss()
            }
        }
    }
    func addDummyData(){
        for i in 2...40{
            sectionList.append(Section(sectionName: "Food Order", sectionNumber: i))
            var temp:[childSection] = []
            for j in 0...40{
                temp.append(childSection(name: "Your orders", image: "takeoutbag.and.cup.and.straw.fill", idx: j))
            }
            sectionChildList.append(temp)
        }
    }
}
/*
 
 struct Profile_Previews: PreviewProvider {
 static var previews: some View {
 Profile()
 }
 }
 */
