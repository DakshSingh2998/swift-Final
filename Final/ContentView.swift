//
//  ContentView.swift
//  Final
//
//  Created by Daksh on 01/01/15.
//

import SwiftUI
import CoreData


class TextModel:ObservableObject{
    @Published var value = ""
    
}

struct ContentView: View {
    @ObservedObject var vmName = TextModel()
    @ObservedObject var vmEmail = TextModel()
    @ObservedObject var vmPass = TextModel()
    @ObservedObject var vmDOB = TextModel()
    @FocusState var nameFocus:Bool
    @FocusState var emailFocus:Bool
    @FocusState var passFocus:Bool
    @FocusState var dobFocus:Bool
    @State var height = 500.0
    @State var temp = ""
    @State var width = Global.shared.width
    @State var tfWidth = Global.shared.width - 100
    @State var loginPage = LoginPage()
    @State var gotoLogin = false
    @State var isNameIncorrect = false
    @State var isEmailIncorrect = false
    @State var isPassIncorrect = false
    @State var isDOBIncorrect = false
    
    var body: some View {
        //NavigationView {
            ScrollView{
                
                
                VStack(spacing: 0){
                    
                    Image(uiImage: UIImage(named: "LaunchScreenImage")!).resizable()
                        .frame(width: 250, height: 200)
                        .scaledToFill()
                        .padding(.horizontal, 50).padding(.vertical, 32)
                    CustomTextField(defaultplaceholder: "Name", vm: vmName, width: $tfWidth, isInCorrect: $isNameIncorrect).focused($nameFocus)
                    CustomTextField(defaultplaceholder: "Email", vm: vmEmail, width: $tfWidth, isInCorrect: $isNameIncorrect).focused($emailFocus)
                    CustomTextField(defaultplaceholder: "Password", vm: vmPass, width: $tfWidth, isProtected: true, isInCorrect: $isNameIncorrect).focused($passFocus)
                    CustomTextField(defaultplaceholder: "dd/mm/yyyy", vm: vmDOB, width: $tfWidth, isInCorrect: $isNameIncorrect, isDate: true, labelText: "Date Of Birth").focused($dobFocus)
                    
                    CustomPrimaryButton(title: "Sign up"){
                        isNameIncorrect = false
                        isEmailIncorrect = false
                        isPassIncorrect = false
                        isDOBIncorrect = false
                        UserDefaults.standard.set(vmPass.value, forKey: vmEmail.value)
                    }.padding(.horizontal, 50).padding(.top, 64)
                    
                    NavigationLink(destination: loginPage, isActive: $gotoLogin){
                        Text("Already have an account, Sign In")
                    }.padding(.top, height/30)
                    
                }.onAppear(){
                    CustomTextField.sendFocus = {received in
                        if(received == "Name"){
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                emailFocus = true
                            }
                        }
                        if(received == "Email"){
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                passFocus = true
                            }
                        }
                        if(received == "Password"){
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                dobFocus = true
                            }
                        }
                        if(received == "Date of Birth"){
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                nameFocus = true
                            }
                        }
                    }
                    self.width = Global.shared.width
                    self.tfWidth = Global.shared.width - 100
                }.padding(.horizontal, 50)
                    .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)){_ in
                        //Global.shared.updateOrientation()
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.8){
                            self.width = Global.shared.width
                            self.tfWidth = Global.shared.width - 100
                            print(self.width)
                        }
                        
                        
                    }
            }
        //}
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension View{
    @ViewBuilder func isHidden(_ hide:Bool) -> some View {
        if hide{
            self.hidden()
        }
        else{
            self
        }
    }
}
