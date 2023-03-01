//
//  CustomNavigation.swift
//  Final
//
//  Created by Daksh on 28/02/23.
//

import SwiftUI

/*
struct CustomNavigation<Content: View>: View {
    @State var title = ""
    var content: Content
    init(title: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
    }
    var body: some View {
        NavigationView{
            content
            
                .navigationTitle(title)
                .navigationBarBackButtonHidden()
                .navigationBarHidden(true)
                .navigationBarItems(leading: HStack{
                    Text(title)
                    VStack(alignment: .leading){
                        Image(systemName: "person")
                        
                    }
                    
                }.frame(maxWidth: .infinity)
                    .frame(minHeight: 20))
            
            
            
        }
        
    }
}


/*
struct ContentView: View {
    var body: some View {
        MyNavigationController(rootView: Text("Hello, world!"))
    }
}

*/
*/
struct CustomNavigation: View{
    @Environment(\.dismiss) var dismiss
    
    @State var title = ""
    
    @Binding var ONPAGE:Double
    @State var rightImage = "person"
    @State var leftImage = "arrowshape.backward"
    @State var gotoProfile = false
    var body: some View{
        ZStack(alignment: .top){
            VStack(spacing: -1){
                HStack{
                    Image(systemName: leftImage).resizable().scaledToFit()
                        .frame(width: 32, height: 32)
                        //.foregroundColor(Color("Dark"))
                        .onTapGesture(perform: {
                            if(leftImage == "arrowshape.backward"){
                                if(ONPAGE == 3.0){
                                    ONPAGE = 1.0
                                    print(ONPAGE)
                                    return
                                }
                                
                                ONPAGE = ONPAGE - 1.0
                            }
                            else{
                                // location code
                            }
                        })
                    Spacer()
                    Text(title).font(Font(CTFont(.system, size: 18))).bold()
                    Spacer()
                    Image(systemName: rightImage).resizable().scaledToFit()
                        .frame(width: 32, height: 32)
                        //.foregroundColor(Color("Dark"))
                        .isHidden(rightImage == "")
                        .onTapGesture(){
                            if(rightImage == "person"){
                                ONPAGE = 5.0
                                gotoProfile = true
                            }
                        }
                }
                .frame(height: 63)
                VStack{
                    
                }
                
                .frame(maxWidth: .infinity)
                
                    .frame(height: 2)
                    .background(Color("Dark"))
                    .padding(.horizontal, -16)
            }
            .padding(16)
            .frame(height: 64)
            .background(Color("Light"))
            NavigationLink("Profile", destination: Profile(ONPAGE: $ONPAGE), isActive: $gotoProfile).hidden()
        }
        //.frame(height: 40)
        //.frame(alignment: .top)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear(){
            
        }
        
        
        
    }
}
