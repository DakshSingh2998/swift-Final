//
//  LoginPage.swift
//  Final
//
//  Created by Daksh on 16/02/23.
//

import SwiftUI

struct LoginPage: View {
    @ObservedObject var vmEmail = TextModel()
    @ObservedObject var vmPass = TextModel()
    @FocusState var emailFocus:Bool
    @FocusState var passFocus:Bool
    @State var width = Global.shared.width
    @State var tfWidth = Global.shared.width - 100
    @State var height = 500.0
    @State var temp = ""
    @State var isPassIncorrect = false
    @State var isEmailIncorrect = false
    var body: some View {
        ScrollView{
            VStack(spacing: 0){
                Image(uiImage: UIImage(named: "Logo")!).resizable()
                    .frame(width: 250, height: 200)
                    .scaledToFill()
                CustomTextField(defaultplaceholder: "Email", vm: vmEmail, width: $tfWidth, isInCorrect: $isEmailIncorrect).focused($emailFocus)
                CustomTextField(defaultplaceholder: "Password", vm: vmPass, width: $tfWidth, isProtected: true, isInCorrect: $isPassIncorrect).focused($passFocus)
                CustomPrimaryButton(title: "Sign in"){
                    isPassIncorrect = false
                    isEmailIncorrect = false
                    var originalPass = UserDefaults.standard.value(forKey: vmEmail.value)
                    if(originalPass == nil){
                        isEmailIncorrect = true
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
                            emailFocus = true
                        }
                        return
                    }
                    if(vmPass.value != originalPass as! String){
                        isPassIncorrect = true
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
                            passFocus = true
                        }
                        print("Incorrect")
                    }else{
                        isPassIncorrect = false
                        isEmailIncorrect = false
                        print("Correct")
                    }
                    
                }.padding(.horizontal, 50).padding(.top, 64).padding(.bottom, 100)
            }.padding(.horizontal, 50)
            .onAppear(){
                self.width = Global.shared.width
                self.tfWidth = Global.shared.width - 100
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)){_ in
                //Global.shared.updateOrientation()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.8){
                    self.width = Global.shared.width
                    self.tfWidth = Global.shared.width - 100
                    print(self.width)
                }
                
                
            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
