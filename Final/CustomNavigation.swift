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
    var body: some View{
        ZStack(alignment: .top){
            VStack(spacing: -1){
                HStack{
                    Image(systemName: "arrowshape.backward")
                        .onTapGesture(perform: {
                            if(ONPAGE == 3.0 || ONPAGE == 4.0){
                                ONPAGE = 1.0
                                print(ONPAGE)
                                return
                            }
                            
                            ONPAGE = ONPAGE - 1.0
                        })
                    Spacer()
                    Text(title)
                    Spacer()
                    Image(systemName: rightImage).isHidden(rightImage == "")
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
        }
        //.frame(height: 40)
        //.frame(alignment: .top)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
        
        
    }
}
