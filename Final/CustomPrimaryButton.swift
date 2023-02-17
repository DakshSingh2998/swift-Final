//
//  CustomPrimaryButton.swift
//  Final
//
//  Created by Daksh on 16/02/23.
//

import SwiftUI

struct CustomPrimaryButton: View{
    @State var title = "Button"
    @State var height:CGFloat = 36
    var closure: (() -> Void)?
    var body: some View {
        Button(action: closure ?? {
            print("Button Action not Defined")
        },label:{
            Spacer()
            Text(title)
            Spacer()
        }).frame(maxWidth: .infinity, minHeight: height).overlay{RoundedRectangle(cornerRadius: 8.0, style: .continuous).stroke( Color("Blue"), lineWidth: 6)}.background(Color("Blue")).cornerRadius(8.0).foregroundColor(.white)
    }
}

 
 struct CustomPrimaryButton_Previews: PreviewProvider {
 static var previews: some View {
 CustomPrimaryButton()
 }
 }
 
