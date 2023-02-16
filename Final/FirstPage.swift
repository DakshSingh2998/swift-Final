//
//  FirstPage.swift
//  Final
//
//  Created by Daksh on 16/02/23.
//

import SwiftUI

struct FirstPage: View {
    @State var width = UIScreen.main.bounds.width
    var signUp = ContentView()
    @State var gotoSignIn = false
    var body: some View {
        NavigationView{
            
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color("Dark"), Color("Light")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                ScrollView{
                    VStack(spacing: -50){
                        Image(uiImage: UIImage(named: "Logo")!).resizable()
                            .frame(width: 250, height: 200)
                            .scaledToFill()
                            
                        CustomSecondaryButton(title: "Sign In"){
                            print("clicked")
                        }.padding(.horizontal, 50).padding(.top, 100)
                        
                        CustomPrimaryButton(title: "Sign up"){
                            gotoSignIn = true
                        }.padding(.horizontal, 50).padding(.top, 64).padding(.bottom, 100)
                        NavigationLink(destination: signUp, isActive: $gotoSignIn){
                        }.hidden()
                        
                    }.frame(height: UIScreen.main.bounds.height)
                }
            }
        }
    }
}

struct FirstPage_Previews: PreviewProvider {
    static var previews: some View {
        FirstPage()
    }
}
