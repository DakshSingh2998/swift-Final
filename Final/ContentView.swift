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
    @Environment(\.dismiss) var dismiss
    @Binding var ONPAGE:Double
    @ObservedObject var vmName = TextModel()
    @ObservedObject var vmEmail = TextModel()
    @ObservedObject var vmPass = TextModel()
    @ObservedObject var vmDOB = TextModel()
    @FocusState var nameFocus:Bool
    @FocusState var emailFocus:Bool
    @FocusState var passFocus:Bool
    @FocusState var dobFocus:Bool
    @State var height = CommonMethods.shared.height
    @State var temp = ""
    @State var width = CommonMethods.shared.width
    @State var tfWidth = CommonMethods.shared.width - 100
    //@State var loginPage:LoginPage?
    //@State var gotoLogin = false
    @State var isNameIncorrect = false
    @State var isEmailIncorrect = false
    @State var isPassIncorrect = false
    @State var isDOBIncorrect = false
    @State var False = false
    @State var successfulSignup = false
    @State var alertText = ""
    @State var CustomNavitaionTitle = "Sign Up"
    var coloredSignIn: AttributedString{
        var result = AttributedString("Sign In")
        result.foregroundColor = Color("Blue")
        result.font = .boldSystemFont(ofSize: 16)
        return result
    }
    
    
    var body: some View {
        ZStack(alignment: .top){
            ScrollView{
                
                
                VStack(spacing: -8){
                    
                    Image(uiImage: UIImage(named: "LaunchScreenImage")!).resizable()
                        .frame(width: 250, height: 200)
                        .scaledToFill()
                    
                        .padding(.bottom, 32)
                    CustomTextField(defaultplaceholder: "Name", vm: vmName, width: $tfWidth, isInCorrect: $isNameIncorrect, commitClosure: {
                        if(CommonMethods.shared.isValidName(vmName.value) == false){
                            isNameIncorrect = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                                nameFocus = true
                            }
                            return
                        }
                        else{
                            isNameIncorrect = False
                        }
                        isEmailIncorrect = false
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                            emailFocus = true
                        }
                    }).focused($nameFocus).onTapGesture {
                        isNameIncorrect = False
                    }
                    ////
                    CustomTextField(defaultplaceholder: "Email", vm: vmEmail, width: $tfWidth, isInCorrect: $isEmailIncorrect, commitClosure: {
                        if(CommonMethods.shared.isValidEmail(vmEmail.value) == false){
                            isEmailIncorrect = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                                emailFocus = true
                            }
                            return
                        }else{
                            isEmailIncorrect = False
                        }
                        isPassIncorrect = false
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                            passFocus = true
                        }
                    }).focused($emailFocus).onTapGesture {
                        isEmailIncorrect = false
                    }
                    CustomTextField(defaultplaceholder: "Password", vm: vmPass, width: $tfWidth, isProtected: true, isInCorrect: $isPassIncorrect, commitClosure: {
                        isDOBIncorrect = false
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                            dobFocus = true
                        }
                    })
                    
                    .focused($passFocus).onTapGesture {
                        isPassIncorrect = false
                    }
                    CustomTextField(defaultplaceholder: "dd/mm/yyyy", vm: vmDOB, width: $tfWidth, isInCorrect: $isDOBIncorrect, isDate: true, labelText: "Date Of Birth", commitClosure: {
                        if(CommonMethods.shared.isValidDate(vmDOB.value) == false){
                            isDOBIncorrect = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                                dobFocus = true
                            }
                            return
                        }else{
                            isDOBIncorrect = False
                        }
                        isNameIncorrect = false
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                            nameFocus = true
                        }
                    }).focused($dobFocus).onTapGesture {
                        isDOBIncorrect = false
                    }
                    
                    CustomPrimaryButton(title: "Sign up"){
                        isNameIncorrect = false
                        isEmailIncorrect = false
                        isPassIncorrect = false
                        isDOBIncorrect = false
                        nameFocus = false
                        emailFocus = false
                        passFocus = false
                        dobFocus = false
                        if(CommonMethods.shared.isValidEmail(vmEmail.value) == false){
                            isEmailIncorrect = true
                        }
                        if(CommonMethods.shared.isValidDate(vmDOB.value) == false){
                            isDOBIncorrect = true
                            
                        }
                        if(CommonMethods.shared.isValidName(vmName.value) == false){
                            isNameIncorrect = true
                        }
                        if(vmPass.value == ""){
                            isPassIncorrect = true
                        }
                        if(isEmailIncorrect || isDOBIncorrect || isNameIncorrect || isPassIncorrect){
                            return
                        }
                        var userData:[UserData] = DatabaseHelper.shared.loadUsers()
                        for i in userData{
                            if(i.email! == vmEmail.value){
                                alertText = "User already present, Please Sign In"
                                successfulSignup = true
                                return
                            }
                        }
                        print("data saved")
                        alertText = "Successful Sign Up"
                        successfulSignup = true
                        
                        //UserDefaults.standard.set(vmPass.value, forKey: vmEmail.value)
                        DatabaseHelper.shared.saveUser(name: vmName.value, email: vmEmail.value, password: vmPass.value, dob: vmDOB.value)
                        //print(DatabaseHelper.shared.loadUsers())
                    }.alert(alertText, isPresented: $successfulSignup, actions: {
                        
                    }).onChange(of: successfulSignup, perform: { newVal in
                        if(successfulSignup == false){
                            ONPAGE = 3.0
                            //gotoLogin = true
                        }
                    })
                    .padding(.top, 32)
                    Text("Already have account? " + coloredSignIn).font(Font(CTFont(.kCTFontSystemFontType, size: 16))).foregroundColor(.black).onTapGesture(perform: {
                        
                        ONPAGE = 3.0
                    }).padding(.vertical, 16)
                }
                .padding(.horizontal, 50)
                .frame(minHeight: self.height - self.height/5)
                
                .onAppear(){
                    print("ONPAGE2 \(ONPAGE)")
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
                    self.width = CommonMethods.shared.width
                    self.height = CommonMethods.shared.height
                    self.tfWidth = CommonMethods.shared.width - 100
                    nameFocus = true
                }
                .onDisappear(){
                    vmName.value = ""
                    vmEmail.value = ""
                    vmPass.value = ""
                    vmDOB.value = ""
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
                
            }
            .navigationBarHidden(true)
            .padding(.top, 40)
        }
        .overlay(CustomNavigation(title: $CustomNavitaionTitle, ONPAGE: $ONPAGE, rightImage: ""))
        .onAppear(){
            vmName.value = "ddd"
            vmEmail.value = "d@gmail.com"
            vmPass.value = "111"
            vmDOB.value = "28/07/2000"
        }
        
        .onChange(of: ONPAGE){newVal in
            if(ONPAGE < 2.0){
                try? dismiss()
            }
        }
         
        
         
    
    }
}
/*

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 */
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
