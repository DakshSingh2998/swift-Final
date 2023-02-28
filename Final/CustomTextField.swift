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
    @Binding var width:CGFloat
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
    var commitClosure: (() -> Void)?
    var body: some View{
        
        
            VStack{
                ZStack{
                    //border
                    VStack{
                    }.frame(width: width-2, height: height+2)
                        
                        .background(isInCorrect ? Color(.systemRed): isFocused ?  Color("Blue") : Color("Grey")).cornerRadius(8.0)
                    //secure tf
                    SecureField(placeholder, text: $vm.value, onCommit: {
                        CustomTextField.sendFocus?(defaultplaceholder)
                        commitClosure?()
                    })
                    .animation(nil)
                    .autocorrectionDisabled(true).textInputAutocapitalization(TextInputAutocapitalization(.none)).frame(width: width-50-6, height: height).textFieldStyle(.roundedBorder)
                    .padding(.trailing, 50)
                    .isHidden(isProtected ? (tempIsProtected ? false : true) : true)

                    //simple tf
                    TextField(placeholder, text: $vm.value).onChange(of: vm.value){newVal in
                        if(isDate == false){
                            return
                        }
                        
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
                        else if(newVal.count <= 10){
                            originalDigit = newVal.count - 2
                        }
                        else{
                            vm.value.remove(at: vm.value.index(vm.value.startIndex, offsetBy: 10))
                        }
                    }.keyboardType(isDate ? .asciiCapableNumberPad : .asciiCapable).onSubmit {
                        commitClosure?()
                    }
                    //CustomTextField.sendFocus!(defaultplaceholder)
                    .animation(nil)
                    .autocorrectionDisabled(true).textInputAutocapitalization(TextInputAutocapitalization(.none)).frame(width: isProtected ? width-6-50 : width-6, height: height).textFieldStyle(.roundedBorder).isHidden(isProtected ? (tempIsProtected ? true : false) : false).padding(.trailing, isProtected ? 50 : 0)
                    //pass image
                    
                    HStack{
                        Image(systemName: tempIsProtected ? "eye.slash.fill" : "eye.fill")
                            .onTapGesture {
                            tempIsProtected = !tempIsProtected
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                                isFocused = true
                            }
                        }
                    }
                    .frame(width: 50+4, height: 36-2.5).background(.white).padding(.leading, width-50-10).cornerRadius(6)
                        .isHidden(!isProtected)
                    ///Label
                    Text(labelText).background(.white).padding(.leading, -width/2.2).padding(.bottom, height+4).contentShape(Rectangle()).foregroundColor(Color("Blue")).opacity(isFocused ? 1 : 0).animation(.linear(duration: 0.1)).font(Font(CTFont(.system, size: 14)))
                    //incorrect label
                    Text(" Incorrect")
                        .background(.white)
                        .foregroundColor(Color(.systemRed)).opacity(isInCorrect ? 1 : 0).animation(.linear(duration: 0.1))
                        .padding(.leading, +width/1.4).padding(.top, height).font(Font(CTFont(.system, size: 14)))
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
    }
}
struct Previews_CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
