//
//  FirstPage.swift
//  Final
//
//  Created by Daksh on 16/02/23.
//

import SwiftUI

struct FirstPage: View {
    @Environment(\.dismiss) var dismiss
    @State var width = CommonMethods.shared.width
    @State var height = CommonMethods.shared.height
    @State var orientation = CommonMethods.shared.currentOrientation
    
    
    @State var gotoSignIn = false
    @State var gotoSignUp = false
    @State var signUpScale = 1.0
    @State var signInScale = 1.0
    @Binding var ONPAGE:Double
    @State var signUp:ContentView?
    @State var signIn:LoginPage?
    @Binding var userData:UserData?
    var body: some View {
        NavigationView
        {
            
            ZStack(alignment: .top){
                LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                //ScrollView{
                VStack(spacing: 10){
                    
                    
                    Image(uiImage: UIImage(named: "Logo")!).resizable()
                        .frame(width: 250, height: 200)
                        .scaledToFill()
                        .padding(.top, 250)
                    //.padding(.top, (orientation == .portrait) ? height/4 : height/1.6)
                    //.padding(.top, Global.shared.height/5)
                    
                    CustomSecondaryButton(title: "Sign In"){
                        print(width)
                        signInScale = 1.2
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                            self.signInScale = 1.0
                            self.ONPAGE = 3.0
                            //self.gotoSignIn = true
                        }
                        
                    }.scaleEffect(signInScale)
                        .animation(.linear(duration: 0.2))
                    
                    CustomPrimaryButton(title: "Sign up"){
                        print(width)
                        signUpScale = 1.2
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                            self.signUpScale = 1.0
                            self.ONPAGE = 2.0
                            //self.gotoSignUp = true
                        }
                        
                    }.scaleEffect(signUpScale)
                        .animation(.linear(duration: 0.2))
                    
                    NavigationLink(destination: signUp, isActive: $gotoSignUp){
                    }.hidden()
                    NavigationLink(destination: signIn, isActive: $gotoSignIn){
                    }.hidden()
                    
                    
                    Image("FirstPageImage1")
                        .resizable().scaledToFit()
                    
                        .frame(height: 300)
                        .padding(.top, height/8)
                    //.isHidden((orientation == .portrait) ? false : true)
                    
                }.padding(.horizontal, 50)
            }
            
            .navigationBarHidden(true)
        }.navigationViewStyle(.stack)
        
        .onAppear(){
            print("ONPAGE1 \(ONPAGE)")
                CommonMethods.shared.updateOrientation()
            signUp = ContentView(ONPAGE: $ONPAGE)
            signIn = LoginPage(ONPAGE: $ONPAGE, userData: $userData)
                if(ONPAGE == 2.0){
                    withAnimation(.linear(duration: 0.3)){
                        self.gotoSignUp = true
                    }
                    
                }
                if(ONPAGE == 3.0){
                    withAnimation(.linear(duration: 0.3)){
                        self.gotoSignIn = true
                    }
                    
                }
                
            }
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)){_ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                        CommonMethods.shared.updateOrientation()
                        self.width = CommonMethods.shared.width
                        self.height = CommonMethods.shared.height
                        self.orientation = CommonMethods.shared.currentOrientation
                    }
                    
                }
                .onChange(of: ONPAGE){newVal in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
                        if(ONPAGE == 2.0){
                            withAnimation(.linear(duration: 0.3)){
                                self.gotoSignUp = true
                            }
                            
                        }
                        if(ONPAGE == 3.0){
                            withAnimation(.linear(duration: 0.3)){
                                self.gotoSignIn = true
                            }
                            
                        }
                    }
                    
                }
                
                
    }
}
/*
 struct FirstPage_Previews: PreviewProvider {
 static var previews: some View {
 FirstPage()
 }
 }
 */
