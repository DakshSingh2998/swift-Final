//
//  CustomPrimaryButton.swift
//  Final
//
//  Created by Daksh on 16/02/23.
//

import SwiftUI

struct CustomPrimaryButton: View{
    @State var title = "Button"
    @State var height:CGFloat = 50
    @State var colorr = Color("Blue")
    var closure: (() -> Void)?
    var body: some View {
        Button(action: closure ?? {
            print("Button Action not Defined")
        },label:{
            Spacer()
            Text(title).fontWeight(.bold)
            Spacer()
        })
        .frame(maxWidth: .infinity, minHeight: height).overlay{RoundedRectangle(cornerRadius: 8.0, style: .continuous).stroke( colorr, lineWidth: 6)}.background(colorr).cornerRadius(8.0).foregroundColor(.white)
        //.buttonStyle(CustomButtonStyle())
        
    }
}

struct CustomButtonStyle: ButtonStyle{
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
        .frame(height: 36)
        
    }
}

 
 struct CustomPrimaryButton_Previews: PreviewProvider {
 static var previews: some View {
 CustomPrimaryButton()
 }
 }
 
