//
//  ContentView.swift
//  Final
//
//  Created by Daksh on 01/01/15.
//

import SwiftUI
import CoreData

struct CustomTextField: View{
    
    var defaultplaceholder:String
    @ObservedObject var vm:TextModel
    @State var labelText = ""
    @State var placeholder = ""
    @State var labelIsHidden = true
    @State var width = UIScreen.main.bounds.width-100
    var height = 36.0
    @State var isProtected = false
    @State var tempIsProtected = false
    @State var label = Text("ctvyghbjk")
    @State var borderColor = Color("Grey")
    @FocusState var isFocused:Bool
    @FocusState var imageIsFocused:Bool
    @State var imageName = "eye.fill"
    @State var temp = true
    /*
    init( tempPlaceholder:String, tempWidth:CGFloat = 300.0){
        defaultplaceholder = tempPlaceholder
        placeholder = tempPlaceholder
        width = tempWidth
        
        //print("ppp", placeholder, tempPlaceholder)
    }
     */
    var body: some View{
        VStack{
            ZStack{
                if(isFocused){
                    VStack{
                    }.frame(width: width+6, height: height+4) .background(Color("Blue")).cornerRadius(8.0)
                }
                else{
                    VStack{
                    }.frame(width: width+6, height: height+4) .background(Color("Grey")).cornerRadius(8.0).onAppear(){
                        label = Text(defaultplaceholder)
                        print("d", defaultplaceholder)
                    }
                }
                if (isProtected){
                    if(tempIsProtected){
                        SecureField(placeholder, text: $vm.value).autocorrectionDisabled(true).onChange(of: vm.value, perform: {newValue in
                            if(newValue == ""){
                                //placeholder = defaultplaceholder
                                withAnimation(.easeOut(duration: 0.2)){
                                    labelIsHidden = true
                                }
                                
                            }
                            else{
                                //placeholder = ""
                                withAnimation(.easeIn(duration: 0.1)){
                                    labelIsHidden = false
                                }
                            }
                            print(labelIsHidden)
                        }).frame(width: width-40, height: height).textFieldStyle(.roundedBorder).padding(.trailing, 40).focused($isFocused)
                        HStack{
                            Image(systemName: "eye.fill")
                        }.frame(width: 40+8, height: 36-2).background(.white).padding(.leading, width-40-8).cornerRadius(6).onTapGesture {
                            tempIsProtected = !tempIsProtected
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                                print(isFocused)
                                isFocused = true
                                print(isFocused)
                            }
                        }
                    }
                    else{
                        TextField(placeholder, text: $vm.value).autocorrectionDisabled(true).onChange(of: vm.value, perform: {newValue in
                            if(newValue == ""){
                                //placeholder = defaultplaceholder
                                withAnimation(.easeOut(duration: 0.2)){
                                    labelIsHidden = true
                                }
                                
                            }
                            else{
                                //placeholder = ""
                                withAnimation(.easeIn(duration: 0.1)){
                                    labelIsHidden = false
                                }
                            }
                            print(labelIsHidden)
                        }).frame(width: width-40, height: height).textFieldStyle(.roundedBorder).padding(.trailing, 40).focused($isFocused)
                        HStack{
                            Image(systemName: "eyes.inverse")
                        }.frame(width: 40+8, height: 36-2).background(.white).padding(.leading, width-40-8).cornerRadius(6).onTapGesture {
                            tempIsProtected = !tempIsProtected
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                                print(isFocused)
                                isFocused = true
                                print(isFocused)
                            }
                            
                        }
                    }
                    
                    
                        
                }
                else{
                    TextField(placeholder, text: $vm.value).autocorrectionDisabled(true).onChange(of: vm.value, perform: {newValue in
                        if(newValue == ""){
                            //placeholder = defaultplaceholder
                            withAnimation(.easeOut(duration: 0.2)){
                                labelIsHidden = true
                            }
                            
                        }
                        
                        else{
                            //placeholder = ""
                            withAnimation(.easeIn(duration: 0.1)){
                                labelIsHidden = false
                            }
                        }
                        print(width)
                    }).frame(width: width, height: height).textFieldStyle(.roundedBorder).focused($isFocused)
                }
                if(isFocused == false){
                    label.background(.white).padding(.leading, -width/2+10).padding(.bottom, height+4).contentShape(Rectangle()).foregroundColor(Color("Blue")).hidden()
                }
                else{
                    label.background(.white).padding(.leading, -width/2+10).padding(.bottom, height+4).contentShape(Rectangle()).foregroundColor(Color("Blue"))
                }
            }
            
        }
            .onAppear(){
            placeholder = defaultplaceholder
            tempIsProtected = isProtected
            
        }
    }
}
class TextModel:ObservableObject{
    @Published var value = ""
}

struct ContentView: View {
    @ObservedObject var vmName = TextModel()
    @ObservedObject var vmEmail = TextModel()
    @ObservedObject var vmPass = TextModel()
    @ObservedObject var vmDOB = TextModel()
    @State var temp = ""
    @State var tfName:CustomTextField? = nil
    @State var tfEmail:CustomTextField? = nil
    @State var tfPass:CustomTextField? = nil
    @State var tfDOB:CustomTextField? = nil
    /*
     var tfEmail = CustomTextField(tempPlaceholder: "Email")
     var tfPass = CustomTextField(tempPlaceholder: "Password")
     var tfDOB = CustomTextField(tempPlaceholder: "Date Of Birth")
     */
    var body: some View {
        NavigationView {
            VStack(spacing: -10){
                Image(uiImage: UIImage(named: "LaunchScreenImage")!).resizable().scaledToFill().frame(height: 50).padding(.top, 150).padding(.horizontal, 20).padding(.bottom, 100)
                tfName
                
                 tfEmail
                 tfPass
                 tfDOB
                 
                Button("SignUp", action: {
                    print(vmName.value, vmEmail.value, vmPass.value, vmDOB.value)
                })
                Spacer()
                
            }.onAppear(){
                //
                
                tfName = CustomTextField(defaultplaceholder: "Name", vm: vmName, placeholder: "Name")
                tfEmail = CustomTextField(defaultplaceholder: "Email", vm: vmEmail, placeholder: "Email")
                tfPass = CustomTextField(defaultplaceholder: "Password", vm: vmPass, placeholder: "Password", isProtected: true)
                tfDOB = CustomTextField(defaultplaceholder: "Date of Birth", vm: vmDOB, placeholder: "Date of Birth")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
