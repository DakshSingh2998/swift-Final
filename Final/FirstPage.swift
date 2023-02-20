//
//  FirstPage.swift
//  Final
//
//  Created by Daksh on 16/02/23.
//

import SwiftUI

struct FirstPage: View {
    @State var width = CommonMethods.shared.width
    @State var signUp = ContentView()
    @State var gotoSignIn = false
    @State var signInScale = 1.0
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
                                signInScale = 1.2
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                                    signInScale = 1.0
                                }
                                
                            }.scaleEffect(signInScale)
                                .animation(.linear(duration: 0.2))
                            
                            CustomPrimaryButton(title: "Sign up"){
                                gotoSignIn = true
                            }
                            NavigationLink(destination: signUp, isActive: $gotoSignIn){
                            }.hidden()
                            
                        }.padding(.horizontal, 50)
                    }
                
            }.onAppear(){
                CommonMethods.shared.updateOrientation()
                signUp = ContentView()
            }
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)){_ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                        CommonMethods.shared.updateOrientation()
                    }
                    
                }
    }
}

struct FirstPage_Previews: PreviewProvider {
    static var previews: some View {
        FirstPage()
    }
}
