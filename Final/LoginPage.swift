//
//  LoginPage.swift
//  Final
//
//  Created by Daksh on 16/02/23.
//

import SwiftUI

struct LoginPage: View {
    @Environment(\.dismiss) var dismiss
    @Binding var ONPAGE:Double
    @ObservedObject var vmEmail = TextModel()
    @ObservedObject var vmPass = TextModel()
    @FocusState var emailFocus:Bool
    @FocusState var passFocus:Bool
    @State var width = CommonMethods.shared.width
    @State var tfWidth = CommonMethods.shared.width - 100
    @State var height = CommonMethods.shared.height
    @State var temp = ""
    @State var isPassIncorrect = false
    @State var isEmailIncorrect = false
    @State var gotoHomePage = false
    @Binding var userData: UserData?
    @State var homePage:HomePage?
    @State var CustomNavitaionTitle = "Log In"
    var body: some View {
        ZStack{
            ScrollView{
                VStack(spacing: -8){
                    Image(uiImage: UIImage(named: "Logo")!).resizable()
                        .frame(width: 250, height: 200)
                        .scaledToFill()
                        .padding(.vertical, -32)
                    CustomTextField(defaultplaceholder: "Email", vm: vmEmail, width: $tfWidth, isInCorrect: $isEmailIncorrect, commitClosure: {
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
                            passFocus = true
                        })
                    }).focused($emailFocus).onTapGesture {
                        isEmailIncorrect = false
                    }
                    CustomTextField(defaultplaceholder: "Password", vm: vmPass, width: $tfWidth, isProtected: true, isInCorrect: $isPassIncorrect, commitClosure: {
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
                            emailFocus = true
                        })
                    }).focused($passFocus).onTapGesture {
                        isPassIncorrect = false
                    }
                    CustomPrimaryButton(title: "Sign in"){
                        
                        isPassIncorrect = false
                        isEmailIncorrect = false
                        emailFocus = false
                        passFocus = false
                        
                        var userData:[UserData] = DatabaseHelper.shared.loadUsers()
                        var email404 = true
                        for i in 0..<userData.count{
                            if(userData[i].email! == vmEmail.value){
                                if(userData[i].password == vmPass.value){
                                    print("Correct")
                                    self.userData = userData[i]
                                    UserDefaults.standard.set(vmEmail.value, forKey: "loggedInUser")
                                    ONPAGE = 4.0
                                    break
                                }
                                else{
                                    isPassIncorrect = true
                                    print("INCorrect")
                                }
                                email404 = false
                            }
                        }
                        if(email404 == true){
                            isEmailIncorrect = true
                            print("dash dash")
                        }
                    }.padding(.top, 32)
                }.padding(.horizontal, 50)
                    .onAppear(){
                        print("ONPAGE3 \(ONPAGE)")
                        self.width = CommonMethods.shared.width
                        self.tfWidth = CommonMethods.shared.width - 100
                        self.height = CommonMethods.shared.height
                        emailFocus = true
                        
                    }
                    .onDisappear(){
                        vmEmail.value = ""
                        vmPass.value = ""
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)){_ in
                        //Global.shared.updateOrientation()
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.8){
                            self.width = CommonMethods.shared.width
                            self.tfWidth = CommonMethods.shared.width - 100
                            self.height = CommonMethods.shared.height
                            print(self.width)
                        }
                    }
                    .frame(minHeight: self.height - self.height/3)
                    .navigationBarHidden(true)
            }
            .padding(.top, 80)
        }.overlay(CustomNavigation(title: $CustomNavitaionTitle, ONPAGE: $ONPAGE, rightImage: ""))
            .onChange(of: ONPAGE){newVal in
                if(ONPAGE < 3.0){
                    try? dismiss()
                }
            }
            .onAppear(){
                vmEmail.value = "d@gmail.com"
                vmPass.value = "111"
            }
    }
}
/*
 struct LoginPage_Previews: PreviewProvider {
 static var previews: some View {
 LoginPage()
 }
 }
 */
