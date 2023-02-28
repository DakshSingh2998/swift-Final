/*
 
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
 }

 struct Profile: View {
     @State var sectionList:[Section] = []
     @State var sectionChildList:[[childSection]] = []
     @State var secNo = 0
     @State var i = 0
     var body: some View {
         ZStack{
             LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                 .ignoresSafeArea()
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
                 
                 LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("LightDark")]), startPoint: .top, endPoint: .bottom)
                     .frame(height: 8)
                     .upperCurve(10, corners: [.bottomLeft, .bottomRight])
                 
                     .background(.clear)
                 
                 List(sectionList){newVVal in
                     VStack(alignment: .leading){
 //                        secNo = newVVal.sectionNumber
 //                        print(sectionNumber)
                         if(newVVal.sectionName == "Food Order"){
                             VStack{
                                 
                             }.frame(height: 20)
                         }
                         Text(newVVal.sectionName).font(Font(CTFont(.system, size: 16))).bold()
                             .onAppear(){
                             secNo = newVVal.sectionNumber
                                 print(secNo)
                                 
                         }
                          VStack{
 //
                              ForEach(sectionChildList[i], id: \.id){ cc in
                                  HStack{
                                      Image(systemName: cc.image)
                                      Text(cc.name)
                                      Spacer()
                                      Text(">")
                                  }
                              }
                               
                          }.padding(.horizontal, 6)
                          
                     }
                     .onAppear(){
                         i = i + 1
                     }
                     
                     .listRowBackground(Color.clear)
                 }
                 .onAppear(){
                     i = 0
                 }
                 .background(.clear)
                 .padding(.top, -2)
                 .listStyle(.plain)
                 
             
             
             
             Spacer()
         }.padding(.all, 10)
             
         }
         .onAppear(){
             
             sectionList.append(Section(sectionName: "Food Order", sectionNumber: 0))
             sectionList.append(Section(sectionName: "More", sectionNumber: 1))
             sectionChildList.append([childSection(name: "Your orders", image: "takeoutbag.and.cup.and.straw.fill"), childSection(name: "Address Book", image: "text.book.closed.fill")])
             sectionChildList.append([childSection(name: "About", image: "info.circle"), childSection(name: "Log Out", image: "power.circle.fill")])
             //print(sectionChildList)
         }
     }
 }

 struct Profile_Previews: PreviewProvider {
     static var previews: some View {
         Profile()
     }
 }

 */
