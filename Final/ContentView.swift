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
    @State var temp = ""

    var body: some View {
        NavigationView {
            VStack(spacing: -10){
                Image(uiImage: UIImage(named: "LaunchScreenImage")!).resizable().scaledToFill().frame(height: 50).padding(.top, 150).padding(.horizontal, 20).padding(.bottom, 100)
                CustomTextField(defaultplaceholder: "Name", vm: vmName).focused($nameFocus)
                CustomTextField(defaultplaceholder: "Email", vm: vmEmail).focused($emailFocus)
                CustomTextField(defaultplaceholder: "Password", vm: vmPass, isProtected: true).focused($passFocus)
                CustomTextField(defaultplaceholder: "Date of Birth", vm: vmDOB).focused($dobFocus)
                 
                Button("SignUp", action: {
                    print(vmName.value, vmEmail.value, vmPass.value, vmDOB.value)
                })
                Spacer()
                
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
            }
        }
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
