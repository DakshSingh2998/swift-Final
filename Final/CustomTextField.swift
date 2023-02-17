//
//  CustomTextField.swift
//  Final
//
//  Created by Daksh on 15/02/23.
//

import Foundation
import SwiftUI
struct CustomTextField: View{
    
    static var sendFocus: ((String) -> Void)?
    var defaultplaceholder:String
    @ObservedObject var vm:TextModel
    @State var placeholder = ""
    @State var width = Global.shared.width
    var height = 36.0
    @State var isProtected = false
    @State var tempIsProtected = false
    @FocusState var isFocused:Bool
    @State var labelOpacity = 0.0
    @Binding var isInCorrect:Bool
    @State var reload = false
    @State var isDate = false
    @State var labelText = ""
    @State var originalDigit = 0
    
    var body: some View{
        
        
            VStack{
                ZStack{
                    //border
                    VStack{
                    }.frame(width: width/1.3+6, height: height+6) .background(isFocused ? isInCorrect ? Color(.systemRed): Color("Blue") : Color("Grey")).cornerRadius(8.0)
                    
                    //secure tf
                    SecureField(placeholder, text: $vm.value, onCommit: {
                        CustomTextField.sendFocus!(defaultplaceholder)
                    })
                    .animation(nil)
                    .autocorrectionDisabled(true).textInputAutocapitalization(TextInputAutocapitalization(.none)).frame(width: width/1.55, height: height).textFieldStyle(.roundedBorder).padding(.trailing, width/8)
                    .isHidden(isProtected ? (tempIsProtected ? false : true) : true)

                    //simple tf
                    TextField(placeholder, text: $vm.value).onChange(of: vm.value){newVal in
                        if(newVal.count <= 1){
                            originalDigit = newVal.count
                        }
                        else if(newVal.count == 2 && originalDigit != 2){
                            originalDigit = 2
                            vm.value = vm.value + "/"
                        }
                        else if(newVal.count == 2 && originalDigit == 2){
                            vm.value.remove(at: vm.value.index(vm.value.startIndex, offsetBy: 1))
                            originalDigit = 1
                        }
                        else  if(newVal.count < 5){
                            originalDigit = newVal.count - 1
                        }
                        else if(newVal.count == 5 && originalDigit != 4){
                            originalDigit = 4
                            vm.value = vm.value + "/"
                        }
                        else if(newVal.count == 5 && originalDigit == 4){
                            vm.value.remove(at: vm.value.index(vm.value.startIndex, offsetBy: 4))
                            originalDigit = 4
                        }
                        else{
                            originalDigit = newVal.count - 2
                        }
                        
                        
                    }
                    //CustomTextField.sendFocus!(defaultplaceholder)
                    .animation(nil)
                    .autocorrectionDisabled(true).textInputAutocapitalization(TextInputAutocapitalization(.none)).frame(width: isProtected ? width/1.55 : width/1.3, height: height).textFieldStyle(.roundedBorder).isHidden(isProtected ? (tempIsProtected ? true : false) : false).padding(.trailing, isProtected ? width/8 : 0)
                    //pass image
                    
                    HStack{
                        Image(systemName: tempIsProtected ? "eye.fill" : "eyes.inverse")
                            .onTapGesture {
                            tempIsProtected = !tempIsProtected
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                                isFocused = true
                            }
                        }
                    }.frame(width: width/7.5, height: 36-2.5).background(.white).padding(.leading, width/1.57).cornerRadius(6)
                        .isHidden(!isProtected)
                    ///Label
                    Text(labelText).background(.white).padding(.leading, -width/2.8).padding(.bottom, height+4).contentShape(Rectangle()).foregroundColor(Color("Blue")).opacity(isFocused ? 1 : 0).animation(.linear(duration: 0.1))
                    //incorrect label
                    Text(" Incorrect")
                        .background(.white)
                        .foregroundColor(Color(.systemRed)).opacity(isInCorrect ? 1 : 0).animation(.linear(duration: 0.1))
                        .padding(.leading, +width/2).padding(.top, height+4)
                }.focused($isFocused)
            
        }.animation(nil)
            .onAppear(){
                placeholder = defaultplaceholder
                tempIsProtected = isProtected
                if(labelText == ""){
                    labelText = defaultplaceholder
                }
                //print("ss",isInCorrect)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)){_ in
                //Global.shared.updateOrientation()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.8){
                    self.width = Global.shared.width
                    print(self.width)
                }
                
                
            }
    }
    
}



struct Previews_CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
