//
//  LoadingScreen.swift
//  Final
//
//  Created by Daksh on 06/03/35.
//

import SwiftUI

struct LoadingScreen: View {
    @State var loadingAngle = 0.0
    @State var ONPAGE:Double = 0.0
    @State var image = "Logo"
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            Image(image).resizable().frame(width: 300, height: 300)
                .foregroundColor(Color("Blue"))
                .rotationEffect(.degrees(loadingAngle))
            if(ONPAGE <= 3.0 && ONPAGE > 0.0){
                FirstPage(ONPAGE: $ONPAGE)
            }
            
            if(ONPAGE >= 4.0){
                HomePage(ONPAGE: $ONPAGE)
            }
        }.onAppear(){
            withAnimation(.linear(duration: 2)){
                loadingAngle = 360.0
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                var loggedInUser = UserDefaults.standard.value(forKey: "loggedInUser")
                print(loggedInUser)
                if(loggedInUser == nil){
                    ONPAGE = 1.0
                }
                else{
                    ONPAGE = 4.0
                }
            })
        }
    }
}
/*
 struct LoadingScreen_Previews: PreviewProvider {
 static var previews: some View {
 LoadingScreen()
 }
 }
 */
