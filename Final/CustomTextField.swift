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
    @State var width = UIScreen.main.bounds.width-100
    var height = 36.0
    @State var isProtected = false
    @State var tempIsProtected = false
    @FocusState var isFocused:Bool
    @State var labelOpacity = 0.0
    var body: some View{
        VStack{
            ZStack{
                //border
                VStack{
                }.frame(width: width+6, height: height+4) .background(isFocused ?  Color("Blue") : Color("Grey")).cornerRadius(8.0)
                
                //secure tf
                SecureField(placeholder, text: $vm.value, onCommit: {
                    CustomTextField.sendFocus!(defaultplaceholder)
                })
                .animation(nil)
                .autocorrectionDisabled(true).textInputAutocapitalization(TextInputAutocapitalization(.none)).frame(width: width-40, height: height).textFieldStyle(.roundedBorder).padding(.trailing, 40)
                .isHidden(isProtected ? (tempIsProtected ? false : true) : true)

                //simple tf
                TextField(placeholder, text: $vm.value, onCommit: {
                    CustomTextField.sendFocus!(defaultplaceholder)
                })
                .animation(nil)
                .autocorrectionDisabled(true).textInputAutocapitalization(TextInputAutocapitalization(.none)).frame(width: width, height: height).textFieldStyle(.roundedBorder).isHidden(isProtected ? (tempIsProtected ? true : false) : false)
                //pass image
                
                HStack{
                    Image(systemName: tempIsProtected ? "eye.fill" : "eyes.inverse")
                        .onTapGesture {
                        tempIsProtected = !tempIsProtected
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                            isFocused = true
                        }
                    }
                }.frame(width: 40+8, height: 36-2).background(.white).padding(.leading, width-40-8).cornerRadius(6)
                    .isHidden(!isProtected)
                ///Label
                Text(defaultplaceholder).background(.white).padding(.leading, -width/2+10).padding(.bottom, height+4).contentShape(Rectangle()).foregroundColor(Color("Blue")).opacity(isFocused ? 1 : 0).animation(.linear(duration: 0.1))
            }.focused($isFocused)
        }.animation(nil)
        .onAppear(){
            placeholder = defaultplaceholder
            tempIsProtected = isProtected
        }
    }
}


