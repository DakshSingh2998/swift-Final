//
//  FirstPage.swift
//  Final
//
//  Created by Daksh on 16/02/23.
//

import SwiftUI

struct FirstPage: View {
    @State var width = Global.shared.width
    var signUp = ContentView()
    @State var gotoSignIn = false
    var body: some View {
            NavigationView{
                
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                    //ScrollView{
                        VStack(spacing: 10){
                            
                            Image(uiImage: UIImage(named: "Logo")!).resizable()
                                .frame(width: 250, height: 200)
                                .scaledToFill()
                            //.padding(.top, Global.shared.height/5)
                            
                            CustomSecondaryButton(title: "Sign In"){
                                print(width)
                            }.padding(.horizontal, 50)
                            
                            CustomPrimaryButton(title: "Sign up"){
                                gotoSignIn = true
                            }.padding(.horizontal, 50)
                            NavigationLink(destination: signUp, isActive: $gotoSignIn){
                            }.hidden()
                            
                        }
                    }
                
            }.onAppear(){
                Global.shared.updateOrientation()
            }
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)){_ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                        Global.shared.updateOrientation()
                    }
                    
                }
    }
}

struct FirstPage_Previews: PreviewProvider {
    static var previews: some View {
        FirstPage()
    }
}
