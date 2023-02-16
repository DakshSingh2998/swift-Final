//
//  CustomPrimaryButton.swift
//  Final
//
//  Created by Daksh on 16/02/23.
//

import SwiftUI

struct CustomPrimaryButton: View{
    @State var title:String?
    @State var height:CGFloat = 36
    var closure: (() -> Void)?
    var body: some View {
        Button(title!, action: closure!).frame(maxWidth: .infinity, minHeight: height)
            .overlay{RoundedRectangle(cornerRadius: 8.0, style: .continuous).stroke( Color("Blue"), lineWidth: 6)}.background(Color("Blue")).cornerRadius(8.0).foregroundColor(.white)
            .contentShape(Rectangle())
    }
}
/*
 
 struct CustomPrimaryButton_Previews: PreviewProvider {
 static var previews: some View {
 CustomPrimaryButton()
 }
 }
 */
