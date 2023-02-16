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
    @State var temp = ""

    var body: some View {
        NavigationView {
            VStack(spacing: -10){
                Image(uiImage: UIImage(named: "LaunchScreenImage")!).resizable().scaledToFill().frame(height: 50).padding(.top, 150).padding(.horizontal, 20).padding(.bottom, 100)
                CustomTextField(defaultplaceholder: "Name", vm: vmName)
                CustomTextField(defaultplaceholder: "Email", vm: vmEmail)
                CustomTextField(defaultplaceholder: "Password", vm: vmPass, isProtected: true)
                CustomTextField(defaultplaceholder: "Date of Birth", vm: vmDOB)
                 
                Button("SignUp", action: {
                    print(vmName.value, vmEmail.value, vmPass.value, vmDOB.value)
                })
                Spacer()
                
            }.onAppear(){
                //
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
